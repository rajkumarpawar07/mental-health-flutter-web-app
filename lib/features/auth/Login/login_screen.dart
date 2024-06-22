import 'dart:ui';
import 'package:ai_chatbot/features/auth/Login/controller/login_screen_controller.dart';
import 'package:ai_chatbot/features/auth/Login/widgets/my_button.dart';
import 'package:ai_chatbot/features/auth/Login/widgets/my_text_field.dart';
import 'package:ai_chatbot/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'widgets/my_square_tile.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
// text editing controllers

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginScreenController());
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey,
                    );
                  },
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: 500,
                      maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      const Text("Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(_opacity),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.50,
                            child: Form(
                              key: controller.loginForKey,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    // username textfield
                                    MyTextField(
                                      controller: controller.email,
                                      hintText: 'Email',
                                      obscureText: false,
                                    ),
                                    const SizedBox(height: 10),
                                    Obx(
                                      () => MyPasswordTextField(
                                        onPressed: () =>
                                            controller.hidePassword.value =
                                                !controller.hidePassword.value,
                                        controller: controller.password,
                                        hintText: 'Password',
                                        obscureText:
                                            controller.hidePassword.value,
                                        icon: Icon(controller.hidePassword.value
                                            ? Icons.visibility_off
                                            : Icons.remove_red_eye),
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // sign in button
                                    Obx(
                                      () => controller.isLoading.value
                                          ? MyButton(
                                              onTap: (() {}),
                                              showLoading: true,
                                            )
                                          : MyButton(
                                              onTap: (() {
                                                controller
                                                    .emailAndPasswordSignIn();
                                              }),
                                            ),
                                    ),

                                    const SizedBox(height: 10),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 00.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const SizedBox(width: 10),
                                              const Text(
                                                'Don\'t have an account?',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                textAlign: TextAlign.start,
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () =>
                                                      Navigator.pushNamed(
                                                          context, '/signUp'),
                                                  child: const Text('Sign Up',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              71,
                                                              233,
                                                              133),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        '/forget-password');
                                                  },
                                                  child: const Text(
                                                    'Forgot Password?',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 71, 233, 133),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
