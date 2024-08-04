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
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/panda_profile.jpeg")),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 10),
                    Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: controller.email,
                        readOnly: true,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          labelStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          hintText: 'email',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          // Handle text input change
                        },
                      ),
                    ),

                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Obx(
                            () => IgnorePointer(
                              ignoring: controller.readOnly.value,
                              child: TextField(
                                controller: controller.name,
                                readOnly: controller.readOnly.value,
                                decoration: InputDecoration(
                                  hintText: 'Enter Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 71, 233, 133),
                                        width: 2),
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
                            'Age',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Obx(
                            () => IgnorePointer(
                              ignoring: controller.readOnly.value,
                              child: TextField(
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
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 71, 233, 133),
                                        width: 2),
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
                          Obx(
                            () => IgnorePointer(
                              ignoring: controller.readOnly.value,
                              child: DropdownButtonFormField<String>(
                                value: controller.gender.text.isNotEmpty
                                    ? controller.gender.text
                                    : null,
                                hint: const Text('Gender'),
                                onChanged: (String? newValue) {
                                  controller.gender.text = newValue ?? '';
                                },
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 71, 233, 133),
                                          width: 2),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle:
                                        TextStyle(color: Colors.grey[500])),
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
                          Obx(
                            () => IgnorePointer(
                              ignoring: controller.readOnly.value,
                              child: TextField(
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
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 71, 233, 133),
                                        width: 2),
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
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Obx(
                            () => TextField(
                              controller: controller.password,
                              readOnly: controller.readOnly.value,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 71, 233, 133),
                                      width: 2),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(controller.showPassword.value
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye),
                                  onPressed: () => controller.showPassword
                                      .value = !controller.showPassword.value,
                                ),
                              ),
                              obscureText: controller.showPassword.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        backgroundColor:
                            const Color.fromARGB(255, 71, 233, 133),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (!controller.readOnly.value) {
                          controller.saveProfile();
                        }
                        controller.readOnly.value = !controller.readOnly.value;
                        // Get.toNamed('/edit-profile');
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
                      ))),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.redAccent,
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
              ),
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
