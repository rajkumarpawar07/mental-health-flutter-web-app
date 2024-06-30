import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AiChatBotController extends GetxController {
  static AiChatBotController get instance => Get.find();

  RxBool isChatBotActive = false.obs;

  RxBool voiceInput = false.obs;

  RxBool micOn = false.obs;
}
