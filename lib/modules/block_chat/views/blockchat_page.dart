import 'package:api_demo/modules/block_chat/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockchatPage extends StatelessWidget {
  BlockchatPage({super.key});

  final BlockchatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "A I - C H A T",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            children: [
              Divider(),
              Expanded(
                flex: 7,
                child: Obx(() {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, item) {
                        final eachMessage = controller
                            .messages[controller.messages.length - 1 - item];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: eachMessage.role == "user"
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return AnimatedOpacity(
                                  opacity: controller.opacity.value,
                                  duration: Duration(milliseconds: 500),
                                  child: AnimatedSlide(
                                    offset: eachMessage.role == "user"
                                        ? controller.rightOffset.value
                                        : controller.leftOffset.value,
                                    duration: Duration(milliseconds: 500),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                      width: Get.width / 1.4,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: eachMessage.role == "user"
                                            ? Colors.blue[100]
                                            : Colors.teal[100],
                                        border: Border.all(width: 2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        eachMessage.message ??
                                            "No message Found",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            onSubmitted: (value) => controller.getChat(),
                            enableSuggestions: true,
                            controller: controller.textcontroller,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: "Type your message...",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => controller.getChat(),
                            child: controller.isloading.value
                                ? Center(child: CircularProgressIndicator())
                                : Icon(
                                    Icons.send,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
