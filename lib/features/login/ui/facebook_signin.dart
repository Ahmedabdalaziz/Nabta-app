import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential?> signInWithFacebook() async {
  try {
    // تسجيل الدخول باستخدام Facebook
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // الحصول على بيانات الاعتماد (Credential) من Facebook
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);

      // تسجيل الدخول باستخدام Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // الحصول على بيانات المستخدم
      final User? user = userCredential.user;
      print('User: ${user?.displayName}');
      print('Email: ${user?.email}');

      // إرجاع UserCredential
      return userCredential;
    } else {
      print('Login failed: ${result.status}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
