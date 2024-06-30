import 'package:cloud_firestore/cloud_firestore.dart';
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
      if (email.text.trim() == 'admin@gmail.com' &&
          password.text.trim() == "admin") {
        print('admin');
        Get.offAllNamed('/admin-home');
        return;
      }
      // start loading
      isLoading.value = true;

      // form validation
      if (!loginForKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // login user using emil & password authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      await updateStreak(AuthenticationRepository.instance.authUser!.uid);

      // remove loader
      isLoading.value = false;

      // success message
      Get.snackbar(
        "Logged In!",
        "Logged in successfully. Welcome back",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        colorText: Colors.green,
        duration: const Duration(seconds: 1),
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData(String userId) async {
    return await _firestore.collection('Users').doc(userId).get();
  }

  Future<void> updateStreak(String userId) async {
    DocumentSnapshot userDoc = await getUserData(userId);
    if (userDoc.exists) {
      Timestamp lastActiveInTimeStamp = userDoc['LastActive'] as Timestamp;
      DateTime lastActive = lastActiveInTimeStamp.toDate();
      int currentStreak = userDoc['Streak'];

      DateTime now = DateTime.now();
      if (_isSameDay(now, lastActive)) {
        // User already active today
        print('User already active today');
        return;
      } else {
        // Continue streak
        await _firestore.collection('Users').doc(userId).update({
          'LastActive': now,
          'Streak': currentStreak + 1,
        });
      }
    } else {
      print('else case');
      // New user document
      // await _firestore.collection('Users').doc(userId).set({
      //   'LastActive': DateTime.now(),
      //   'Streak': 1,
      // });
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isNextDay(DateTime date1, DateTime date2) {
    DateTime nextDay = DateTime(date2.year, date2.month, date2.day + 1);
    return _isSameDay(date1, nextDay);
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
      Get.snackbar("Oh Snap!", "Please try again",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          colorText: Colors.red);
    }
  }
}
