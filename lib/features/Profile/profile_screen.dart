import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_repo.dart';
import 'Controller/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileScreenController.instance;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Color.fromARGB(255, 71, 233, 133),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                child: Center(
                  child: Hero(
                    tag: 'profilePic',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade800,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.black,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            image: NetworkImage(
                                'data:image/jpeg;base64,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'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 250,
                  child: Obx(
                    () => TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: controller.name,
                      readOnly: controller.readOnly.value,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        labelStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'user name',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Handle text input change
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 250, // Adjust width as needed
                child: Obx(
                  () => TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: controller.email,
                    readOnly: controller.readOnly.value,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: "user email",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // Handle text input change
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Age',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 200, // Adjust width as needed
                      child: Obx(
                        () => TextField(
                          keyboardType: TextInputType.number,
                          controller: controller.age,
                          readOnly: controller.readOnly.value,
                          decoration: InputDecoration(
                            hintText: 'Enter age',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            // Handle text input change
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 200, // Adjust width as needed
                      child: Obx(
                        () => TextField(
                          controller: controller.gender,
                          readOnly: controller.readOnly.value,
                          decoration: InputDecoration(
                            hintText: 'Enter Gender',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            // Handle text input change
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 200, // Adjust width as needed
                      child: Obx(
                        () => TextField(
                          controller: controller.phoneNumber,
                          readOnly: controller.readOnly.value,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            // Handle text input change
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(255, 71, 233, 133),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (!controller.readOnly.value) {
                      controller.saveProfile();
                    }
                    controller.readOnly.value = !controller.readOnly.value;
                  },
                  child: Obx(
                    () => controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ))
                        : Text(
                            controller.readOnly.value
                                ? "Edit Profile"
                                : "Save Profile",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(255, 71, 233, 133),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    showLogoutDialog(context);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.logout,
                  size: 80.0,
                  color: Colors.red,
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                const Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        AuthenticationRepository.instance.logout();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
