import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_repo.dart';
import '../../../../services/user_repo.dart';
import '../data/user_model.dart';

class SignupScreenController extends GetxController {
  static SignupScreenController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final gender = TextEditingController();
  final phoneNumber = TextEditingController();
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  RxBool isLoading = false.obs;

  GlobalKey<FormState> SignUpFormKey = GlobalKey<FormState>();

  /// -- SignUp
  void SignUp() async {
    try {
      // start loader
      isLoading.value = true;

      // form validation
      if (!SignUpFormKey.currentState!.validate()) {
        return;
      }

      // check if age is integer only
      final ans = isNumeric(age.text.trim());
      if (!ans) {
        Get.snackbar('Age should be integer', 'Age should be integer only',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(10),
            colorText: Colors.red);
        return;
      }

      if (password.text.trim() != confirmPassword.text.trim()) {
        Get.snackbar('Password not matched',
            'password and confirm password should be same',
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(10),
            colorText: Colors.red);
        return;
      }

      // register user and save the data in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // save authenticated user data in firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          name: name.text.trim(),
          email: email.text.trim(),
          age: int.parse(age.text.trim()),
          gender: gender.text.trim(),
          password: password.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          streak: 1,
          lastActive: Timestamp.now(),
          profilePicture: "");

      final userRepository = Get.put(UserRepositoy());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      isLoading.value = false;

      //  show success msg
      Get.snackbar('Congratulations',
          'Your account has been created! Check your mailbox and verify email to continue...',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
          colorText: Colors.green);

      await AuthenticationRepository.instance.sendEmailVerfication();

      name.clear();
      email.clear();
      age.clear();
      password.clear();
      confirmPassword.clear();
      gender.clear();
      phoneNumber.clear();
      gender.text = '';
      // move to verify screen
      Get.offNamed('/');
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Oh Snap!', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    }
  }

  bool isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }
}
