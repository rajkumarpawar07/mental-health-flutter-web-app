import 'package:ai_chatbot/services/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/auth/SignUp/data/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRespository = Get.put(UserRepositoy());

  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRespository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // first update Rx User and then check if user data is already stored. If not then store the data
      await fetchUserRecord();

      // if no record already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // convert name to first and last name

          // map data
          final user = UserModel(
              id: userCredentials.user!.uid,
              name: userCredentials.user!.displayName ?? '',
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '',
              age: 0,
              gender: '',
              password: '',
              streak: 0,
              lastActive: Timestamp.now());

          // save user data
          await userRespository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Get.snackbar("Data not saved",
          "Something went While saving your information. You can re-save your data in your profile.",
          colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
