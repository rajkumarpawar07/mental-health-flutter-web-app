import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Login/widgets/my_button.dart';
import '../Login/widgets/my_text_field.dart';
import 'controller/signup_screen_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  // text editing controllers

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: 500,
                      maxHeight: MediaQuery.of(context).size.height),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        // IconButton(
                        //   icon: const Icon(Icons.arrow_back_ios),
                        //   color: Colors.white,
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        // ),

                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Text("Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: _sigmaX, sigmaY: _sigmaY),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 0, 1)
                                      .withOpacity(_opacity),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30))),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Form(
                                key: controller.SignUpFormKey,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: 10),
                                        const Text(
                                            "Look like you don't have an account. Let's create a new one.",
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.start),
                                        const SizedBox(height: 10),
                                        MyTextField(
                                          controller: controller.name,
                                          hintText: 'Name',
                                          obscureText: false,
                                        ),
                                        const SizedBox(height: 10),
                                        MyTextField(
                                          controller: controller.email,
                                          hintText: 'Email',
                                          obscureText: false,
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          validator: (val) => val!.isEmpty
                                              ? 'Can\'t be empty'
                                              : null,
                                          controller: controller.phoneNumber,
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 71, 233, 133),
                                                    width: 2),
                                              ),
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              hintText: '+91 Phone number',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[500])),
                                        ),
                                        const SizedBox(height: 10),
                                        MyTextField(
                                          isNumber: true,
                                          controller: controller.age,
                                          hintText: 'Age',
                                          obscureText: false,
                                        ),
                                        const SizedBox(height: 10),
                                        // MyTextField(
                                        //   controller: controller.gender,
                                        //   hintText: 'Gender',
                                        //   obscureText: false,
                                        // ),
                                        DropdownButtonFormField<String>(
                                          value:
                                              controller.gender.text.isNotEmpty
                                                  ? controller.gender.text
                                                  : null,
                                          hint: Text('Gender'),
                                          onChanged: (String? newValue) {
                                            controller.gender.text =
                                                newValue ?? '';
                                          },
                                          items: <String>[
                                            'Male',
                                            'Female',
                                            'Other'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 71, 233, 133),
                                                    width: 2),
                                              ),
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[500])),
                                        ),

                                        const SizedBox(height: 10),
                                        Obx(
                                          () => MyPasswordTextField(
                                            obscureText:
                                                controller.hidePassword.value,
                                            onPressed: () => controller
                                                    .hidePassword.value =
                                                !controller.hidePassword.value,
                                            icon: Icon(
                                                controller.hidePassword.value
                                                    ? Icons.visibility_off
                                                    : Icons.remove_red_eye),
                                            controller: controller.password,
                                            hintText: 'Password',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Obx(
                                          () => MyPasswordTextField(
                                            obscureText: controller
                                                .hideConfirmPassword.value,
                                            onPressed: () => controller
                                                    .hideConfirmPassword.value =
                                                !controller
                                                    .hideConfirmPassword.value,
                                            icon: Icon(controller
                                                    .hideConfirmPassword.value
                                                ? Icons.visibility_off
                                                : Icons.remove_red_eye),
                                            controller:
                                                controller.confirmPassword,
                                            hintText: 'Confirm Password',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            // RichText(
                                            //   text: const TextSpan(
                                            //     text: '',
                                            //     children: <TextSpan>[
                                            //       TextSpan(
                                            //         text:
                                            //             'By selecting Agree & Continue below, I agree to our ',
                                            //         style: TextStyle(
                                            //             color: Colors.white,
                                            //             fontSize: 20),
                                            //       ),
                                            //       TextSpan(
                                            //           text:
                                            //               'Terms of Service and Privacy Policy',
                                            //           style: TextStyle(
                                            //               color: Color.fromARGB(
                                            //                   255, 71, 233, 133),
                                            //               fontWeight: FontWeight.bold,
                                            //               fontSize: 20)),
                                            //     ],
                                            //   ),
                                            // ),
                                            const SizedBox(height: 10),
                                            Obx(
                                              () => MyButtonAgree(
                                                text: controller.isLoading.value
                                                    ? 'Please wait...'
                                                    : "Sign up",
                                                onTap: () {
                                                  controller.SignUp();
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
