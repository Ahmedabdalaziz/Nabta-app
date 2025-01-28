import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  // Access user information
  User? user = userCredential.user;
  if (user != null) {
    log("Email: ${user.email}");
    log("Display Name: ${user.displayName}");
    log("Photo URL: ${user.photoURL}");
    log("UID: ${user.uid}");
    log("ID Token: ${googleAuth?.idToken}");
    log("access Token: ${googleAuth?.accessToken}");
  } else {
    log("User is null");
  }

  return userCredential;
}
