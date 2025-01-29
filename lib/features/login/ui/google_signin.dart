import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/core/networking/api_constants.dart';
import 'package:http/http.dart' as http;

Future<UserCredential?> signInWithGoogleAndSendData() async {
  try {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      log("المستخدم ألغى العملية");
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) {
      log("تعذر الحصول على بيانات المستخدم");
      return null;
    }

    log("تم تسجيل الدخول بنجاح: ${user.email}");

    final userData = {
      "email": user.email,
      "displayName": user.displayName,
      "photoURL": user.photoURL,
      "uid": user.uid,
      "idToken": googleAuth.idToken,
      "accessToken": googleAuth.accessToken,
    };

    log("إرسال البيانات إلى الباك اند: ${jsonEncode(userData)}");

    final response = await http.post(
      Uri.parse("${ApiConstants.apiBaseUrl}auth/googleoauth"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );

    log("استجابة الباك اند: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200) {
      try {
        await TokenManager().saveToken(googleAuth.idToken!);
      } catch (e) {
        log("فشل تخزين التوكين");
      }
      return userCredential;
    } else {
      log("فشل إرسال البيانات إلى الباك اند");
      return null;
    }
  } catch (e) {
    log("خطأ أثناء تسجيل الدخول أو إرسال البيانات: $e");
    return null;
  }
}
