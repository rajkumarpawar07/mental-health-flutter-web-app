import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AiChatBotController extends GetxController {
  static AiChatBotController get instance => Get.find();

  final chatController = TextEditingController();
  RxBool isChatBotActive = false.obs;
}
