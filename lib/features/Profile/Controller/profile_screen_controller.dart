import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth_repo.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get instance => Get.find();
  String? userId = AuthenticationRepository.instance.authUser?.uid;
  final age = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final gender = TextEditingController();
  final password = TextEditingController();
  RxBool readOnly = true.obs;
  RxBool isLoading = false.obs;
  int streak = 0;
  String tempEmail = '';
  String tempPassword = '';
  // AuthenticationRepository.instance.authUser?.uid
  RxBool showPassword = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      // Assuming user ID is known and stored in userId variable
      // Replace with actual user ID
      print(userId);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        age.text = userDoc['Age'].toString();
        name.text = userDoc['Name'];
        email.text = userDoc['Email'];
        phoneNumber.text = userDoc['PhoneNumber'];
        gender.text = userDoc['Gender'];
        streak = userDoc['Streak'];
        password.text = userDoc['Password'];
        tempEmail = userDoc['Email'];
        tempPassword = userDoc['Password'];
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> saveProfile() async {
    isLoading.value = true;
    if (password.text != tempPassword) {
      // update email with password
      await AuthenticationRepository.instance.changeEmailPassword(
        currentEmail: tempEmail,
        currentPassword: tempPassword,
        newEmail: email.text,
        newPassword: password.text,
      );
      isLoading.value = false;
      return;
    }

    await FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'Name': name.text.trim(),
      'Age': age.text.trim(),
      'Email': email.text.trim(),
      'PhoneNumber': phoneNumber.text.trim(),
      'Gender': gender.text.trim(),
      'Password': password.text.trim(),
    }).then((value) {
      isLoading.value = false;
      Get.snackbar(
        "Profile updated!",
        "Profile updated successfully.",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        colorText: Colors.green,
        duration: const Duration(seconds: 2),
      );
      print("Profile Updated");
    }).catchError((error) {
      isLoading.value = false;
      print("Failed to update profile: $error");
    });
  }

  Future<void> updateUserProfileAfterEmailAndPasswordChanged() async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'Name': name.text.trim(),
        'Age': age.text.trim(),
        'Email': email.text.trim(),
        'PhoneNumber': phoneNumber.text.trim(),
        'Password': password.text.trim(),
        'Gender': gender.text.trim()
      }).then((value) {
        tempPassword = password.text;
        isLoading.value = false;
        Get.snackbar(
          "Profile updated!",
          "Profile updated successfully.",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          colorText: Colors.green,
          duration: const Duration(seconds: 2),
        );
        print("Profile Updated");
      }).catchError((error) {
        isLoading.value = false;
        print("Failed to update profile: $error");
      });
    } catch (e) {
      print(
          'error in updating profile of user with changed email and password => $e');
    } finally {
      isLoading.value = false;
    }
  }
}
