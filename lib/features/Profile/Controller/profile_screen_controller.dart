import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  RxBool readOnly = true.obs;
  RxBool isLoading = false.obs;
  // AuthenticationRepository.instance.authUser?.uid
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
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> saveProfile() async {
    isLoading.value = true;
    await FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'Name': name.text,
      'Age': age.text,
      'Email': email.text,
      'PhoneNumber': phoneNumber.text,
      'Gender': gender.text,
    }).then((value) {
      isLoading.value = false;
      print("Profile Updated");
    }).catchError((error) {
      isLoading.value = false;
      print("Failed to update profile: $error");
    });
  }
}
