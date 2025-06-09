import 'package:api_demo/modules/block_chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BlockchatController extends GetxController {
  var textcontroller = TextEditingController();
  var messages = <Message>[].obs;
  final FetchBlockchat _service = Get.find();
  var isloading = false.obs;
  var opacity = 0.0.obs;
  final scrollController = ScrollController();
  var leftOffset = Offset(-2.0, 0).obs;
  var rightOffset = Offset(2.0, 0).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    messages.add(
      Message(role: "ai", message: "Hello User! I am here to help!"),
    );
    Future.delayed(Duration(milliseconds: 100), () {
      opacity.value = 1.0;
      leftOffset.value = Offset(0, 0);
      rightOffset.value = Offset(0, 0);
    });
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0, // 👈 Because reverse: true, we scroll to 0
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> getChat() async {
    if (textcontroller.text.isNotEmpty) {
      isloading.value = true;
      final chatMessage =
          await _service.fetchChat(textcontroller.text) ??
          Message(
            role: 'ai',
            message: "Something went wrong\n Please Try Again.",
          );

      messages.add(Message(role: 'user', message: textcontroller.text));
      chatMessage.message = chatMessage.message!.replaceAll("**", "");
      chatMessage.message = chatMessage.message!.replaceAll("*", "");
      chatMessage.message = chatMessage.message!.replaceAll("  ", "");

      messages.add(
        Message(role: chatMessage.role, message: chatMessage.message),
      );
      isloading.value = false;
      textcontroller.clear();
      Get.focusScope?.unfocus();
      await Future.delayed(Duration(milliseconds: 500), () {
        scrollToBottom();
        opacity.value = 1.0;
        leftOffset.value = Offset(0, 0);
        rightOffset.value = Offset(0, 0);
      });
    } else {
      Get.snackbar("error", "Please Give Some Prompt for Continue");
    }
  }
}
