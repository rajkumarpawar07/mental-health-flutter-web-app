import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import 'controller/chat_bot_controller.dart';

class AiChatbotScreen extends StatefulWidget {
  @override
  State<AiChatbotScreen> createState() => _AiChatbotScreenState();
}

class _AiChatbotScreenState extends State<AiChatbotScreen> {
  final TextToSpeech tts = TextToSpeech();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AiChatBotController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Go ahead. ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "I'm listening",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   gradient: RadialGradient(
                    //     colors: [Colors.blueAccent, Colors.deepPurple],
                    //   ),
                    // ),
                    child: Center(
                      child: Obx(
                        () => Lottie.asset(
                          animate: controller.isChatBotActive.value,

                          'assets/lottie/home_animation.json',
                          // Replace with your SVG asset
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      maxWidth: 500,
                    ),
                    child: Container(
                      height: 50,
                      // margin: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        border: Border.all(color: Colors.grey[600]!, width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8), // Adjust padding as needed

                        child: TextField(
                          controller: controller.chatController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            suffixIcon: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.send, color: Colors.white),
                                    onPressed: () async {
                                      if (controller
                                          .chatController.text.isEmpty) return;
                                      controller.isChatBotActive.value = true;
                                      print('send button pressed');
                                      final responseText =
                                          await getResponseFromGemini(
                                              controller.chatController.text);
                                      controller.chatController.clear();
                                      try {
                                        await tts.speak(responseText!);
                                        controller.isChatBotActive.value =
                                            false;
                                      } catch (e) {
                                        controller.isChatBotActive.value =
                                            false;
                                        print('Error:==> $e');
                                      }
                                    },
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.mic,
                                          color: Colors.white),
                                      onPressed: () {
                                        tts.speak('this is working fine');
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Future<String?> getResponseFromGemini(String textCommand) async {
  //   const apiKey = 'AIzaSyB9PPIcUhgvCROjdkMzfcmPTsiEo0Nbytw';
  //   final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  //   final content = [Content.text(textCommand)];
  //   final response = await model.generateContent(content);
  //   print('response from gemini: ${response.text}');
  //   return response.text;
  // }

  Future<String?> getResponseFromGemini(String textCommand) async {
    const String apiKey =
        'AIzaSyB9PPIcUhgvCROjdkMzfcmPTsiEo0Nbytw'; // Replace with your actual API key
    const String apiUrl =
        'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey';

    // Create the request payload
    final Map<String, dynamic> payload = {
      "contents": [
        {
          "parts": [
            {"text": textCommand}
          ]
        }
      ]
    };

    // Convert payload to JSON
    final String jsonPayload = jsonEncode(payload);

    // Make the HTTP POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonPayload,
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Extract the text part
      final String text =
          responseData['candidates'][0]['content']['parts'][0]['text'];
      print('Response text: $text');
      return text;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return '';
    }
  }
}

class TextToSpeech {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }
}
