import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Controller/profile_screen_controller.dart';

class EditProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ProfileScreenController.instance;
    return Container(
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: controller.name,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.age,
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: controller.gender.text.isNotEmpty
                ? controller.gender.text
                : null,
            hint: const Text('Gender'),
            onChanged: (String? newValue) {
              controller.gender.text = newValue ?? '';
            },
            items: <String>['Male', 'Female', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 71, 233, 133), width: 2),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[500])),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => TextField(
              controller: controller.password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(controller.showPassword.value
                      ? Icons.visibility_off
                      : Icons.remove_red_eye),
                  onPressed: () => controller.showPassword.value =
                      !controller.showPassword.value,
                ),
              ),
              obscureText: controller.showPassword.value,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
