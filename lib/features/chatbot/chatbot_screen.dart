import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
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
  stt.SpeechToText speech = stt.SpeechToText();
  bool speechEnabled = false;
  final chatController = TextEditingController();
  String _wordsSpoken = "";

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  Future<void> initSpeech() async {
    bool available = await speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (errorNotification) => print('onError: $errorNotification'),
    );
    setState(() {
      speechEnabled = available;
    });
    if (available) {
      print('Speech recognition available');
    } else {
      print('Speech recognition not available');
    }
  }

  Future<void> startListening() async {
    speech.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  Future<void> stopListening() async {
    await speech.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
      print('Spoken words: $_wordsSpoken');
      chatController.text = _wordsSpoken;
    });
  }

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
                  child: Stack(children: [
                    Center(
                      child: Obx(
                        () => Lottie.asset(
                          animate: controller.isChatBotActive.value,
                          'assets/lottie/ai_animation.json',
                          // Replace with your SVG asset
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    Center(
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
                  ]),
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
                            horizontal: 20, vertical: 8),
                        child: TextField(
                          controller: chatController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: speech.isListening
                                ? "listening..."
                                : 'Type a message',
                            contentPadding: const EdgeInsets.symmetric(
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
                                      if (speech.isListening) {
                                        await stopListening();
                                      }
                                      controller.micOn.value = false;
                                      if (chatController.text.isEmpty) return;
                                      controller.isChatBotActive.value = true;
                                      print('send button pressed');
                                      tts.stopTheSpeech();
                                      final responseText =
                                          await getResponseFromGemini(
                                              chatController.text);
                                      chatController.clear();

                                      // Set the onComplete callback to update isChatBotActive
                                      tts.onComplete = () {
                                        controller.isChatBotActive.value =
                                            false;
                                      };

                                      try {
                                        await tts.speak(responseText!);
                                        controller.isChatBotActive.value =
                                            true; // Set to true when speaking starts
                                      } catch (e) {
                                        controller.isChatBotActive.value =
                                            false;
                                        print('Error:==> $e');
                                      }
                                    },
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // Obx(
                                  //   () => controller.voiceInput.value
                                  //       ? Tooltip(
                                  //           message: 'Try it',
                                  //           child: GestureDetector(
                                  //             onTap: () {
                                  //               speech.isListening
                                  //                   ? stopListening()
                                  //                   : startListening();
                                  //               controller.voiceInput.value =
                                  //                   !controller
                                  //                       .voiceInput.value;
                                  //               tts.speak(
                                  //                   'this is working fine');
                                  //             },
                                  //             child: Lottie.asset(
                                  //               fit: BoxFit.cover,
                                  //               animate: true,
                                  //               filterQuality:
                                  //                   FilterQuality.high,
                                  //               'assets/lottie/input_mic.json',
                                  //               height: 50,
                                  //             ),
                                  //           ),
                                  //         )
                                  //       : Tooltip(
                                  //           message: 'Try it',
                                  //           child: GestureDetector(
                                  //             onTap: () {
                                  //               speech.isListening
                                  //                   ? stopListening()
                                  //                   : startListening();
                                  //               controller.voiceInput.value =
                                  //                   !controller
                                  //                       .voiceInput.value;
                                  //               tts.speak(
                                  //                   'this is working fine');
                                  //             },
                                  //             child: Lottie.asset(
                                  //               filterQuality:
                                  //                   FilterQuality.high,
                                  //               fit: BoxFit.cover,
                                  //               animate: false,
                                  //               'assets/lottie/input_mic.json',
                                  //               height: 50,
                                  //             ),
                                  //           ),
                                  //         ),
                                  // ),
                                  Obx(
                                    () => Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        // shape: BoxShape.circle,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () async {
                                            controller.micOn.value =
                                                !controller.micOn.value;
                                            if (speech.isListening) {
                                              await stopListening();
                                              tts.stopTheSpeech();
                                              if (chatController.text.isEmpty)
                                                return;
                                              controller.isChatBotActive.value =
                                                  true;
                                              print('send button pressed');
                                              final responseText =
                                                  await getResponseFromGemini(
                                                      chatController.text);

                                              // Set the onComplete callback to update isChatBotActive
                                              tts.onComplete = () {
                                                controller.isChatBotActive
                                                    .value = false;
                                              };

                                              try {
                                                await tts.speak(responseText!);
                                                controller
                                                        .isChatBotActive.value =
                                                    true; // Set to true when speaking starts
                                              } catch (e) {
                                                controller.isChatBotActive
                                                    .value = false;
                                                print('Error:==> $e');
                                              }
                                              chatController.clear();
                                              _wordsSpoken = '';
                                            } else {
                                              await startListening();
                                            }
                                          },
                                          icon: Icon(
                                            controller.micOn.value
                                                ? Icons.mic
                                                : Icons.mic_off,
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
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

  TextToSpeech() {
    // Set up the completion handler
    flutterTts.setCompletionHandler(() {
      onComplete();
    });
  }

  stopTheSpeech() {
    flutterTts.stop();
  }

  // Function to be called when speech is completed
  void Function() onComplete = () {};
  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }
}
