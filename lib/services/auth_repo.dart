import 'package:ai_chatbot/features/auth/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../features/home/home_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// variables
  // final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get authenticated user data when ever need
  User? get authUser => _auth.currentUser;

  /// called from main.dart on app launch

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('Error: $e');
      throw e.toString();
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// -- send email Verification [EmailVerification]
  Future<void> sendEmailVerfication() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// -- Google [GoogleAuth]
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // create a new credentials
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // once sign in , return the credentials
      return await _auth.signInWithCredential(credentials);
    } catch (e) {
      print('Error:==> $e');
      throw "Something went wrong. Please try again";
    }
  }
}
