import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_repo.dart';

class Forgetpasswordscreencontroller extends GetxController {
  static Forgetpasswordscreencontroller get instance => Get.find();

  /// variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  /// send reset password email
  Future<void> sendPasswordResetEmail() async {
    try {
      // start loader
      isLoading.value = true;

      // form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        return;
      }

      // -- send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // remove loader
      isLoading.value = false;

      Get.snackbar(
        "Email Sent!",
        "An email link sent to reset your password.".tr,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.green,
        margin: EdgeInsets.all(10),
      );
    } catch (e) {
      // remove loader
      isLoading.value = false;
      Get.snackbar(
        "Oh Snap!",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        margin: EdgeInsets.all(10),
      );
    }
  }
}
