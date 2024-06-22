import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../auth/SignUp/data/user_model.dart';

class AdminHomeController extends GetxController {
  var users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('Users').get();
      var userList =
          snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
      users.assignAll(userList);
    } catch (e) {
      print('error $e');
    }
  }
}
