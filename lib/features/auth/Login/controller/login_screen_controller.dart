import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_repo.dart';
import '../../../../services/user_controller.dart';

class LoginScreenController extends GetxController {
  static LoginScreenController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final isLoading = false.obs;
  GlobalKey<FormState> loginForKey = GlobalKey<FormState>();
  final hidePassword = true.obs;
  final userController = Get.put(UserController());

  /// -- Email and password signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      // start loading
      isLoading.value = true;

      // form validation
      if (!loginForKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // final _auth = FirebaseAuth.instance;
      // final user = _auth.currentUser;
      // if (user != null) {
      //   // if user is logged in
      //   if (!user.emailVerified) {
      //     Get.snackbar(
      //       'Email verification pending...',
      //       'Please verify your email in order to continue...',
      //       snackPosition: SnackPosition.BOTTOM,
      //       colorText: Colors.green,
      //       margin: EdgeInsets.all(10),
      //     );
      //     return;
      //   }
      // }

      // login user using emil & password authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      isLoading.value = false;

      // success message
      Get.snackbar(
        "Logged In!",
        "Logged in successfully. Welcome back",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        colorText: Colors.green,
      );

      // redirect
      Get.offNamed('/home');
    } catch (e) {
      print('Error:==> $e');
      isLoading.value = false;
      Get.snackbar(
        "Oh Snap!",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        colorText: Colors.red,
      );
    }
  }

  RxBool signingWithGoogle = false.obs;

  /// -- Google Sign IN
  Future<void> googleSignIn() async {
    try {
      // loader
      signingWithGoogle.value = true;

      // Google auth
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // store user credentials to fireStore
      await userController.saveUserRecord(userCredentials);

      // stop loader
      signingWithGoogle.value = false;

      // redirect
      Get.offNamed('/home');
    } catch (e) {
      print('Error:==> $e');
      signingWithGoogle.value = false;
      Get.snackbar("Oh Snap!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          colorText: Colors.red);
    }
  }
}
