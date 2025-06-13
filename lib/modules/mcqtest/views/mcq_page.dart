import 'package:api_demo/core/app.dart';
import 'package:api_demo/modules/mcqtest/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icons_plus/icons_plus.dart';

class McqPage extends StatelessWidget {
  McqPage({super.key});
  final McqController controller = Get.find();

  String _getMessage(int score) {
    switch (score) {
      case 0:
      case 1:
        return "You can do better!";
      case 2:
        return "Not bad, keep practicing!";
      case 3:
        return "Good job!";
      case 4:
        return "Great work!";
      case 5:
        return "You outdid yourself!";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: GestureDetector(
            onTap: () => controller.pageviewController.jumpToPage(2),
            child: Text(
              "M C Q s",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: PageView(
            controller: controller.pageviewController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 30,
                    children: [
                      Text(
                        "Welcome TO MCQ Generator!",
                        style: TextStyle(
                          fontSize: 40,
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(7, 7)),
                            Shadow(color: Colors.black12, offset: Offset(5, 5)),
                          ],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Here you can enter the any topic and our ai will help you generate the MCQs for that, after taking a test you can check you performance in score section.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextField(
                                controller: controller.textcontroller,
                                decoration: InputDecoration(
                                  hint: Text(
                                    "Enter topic here...",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal,
                              offset: Offset(7, 7),
                              blurStyle: BlurStyle.solid,
                            ),
                            BoxShadow(
                              color: Colors.white38,
                              offset: Offset(5, 5),
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (controller.textcontroller.text.isEmpty) {
                              Get.snackbar("Error", "Please Enter Topic First");
                            } else {
                              controller.pageviewController.jumpToPage(1);
                              controller.getMcq();
                              FocusScope.of(context).unfocus();
                            }
                          },
                          child: Text(
                            "Let's Start",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: controller.isloading.value
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          spacing: 20,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(() {
                                return Text(
                                  controller
                                      .mcqs
                                      .value!
                                      .questions![controller
                                          .questionIndex
                                          .value]
                                      .question,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }),
                            ),

                            Obx(() {
                              final selected =
                                  controller.selectedOptionEach.value;
                              final question = controller
                                  .mcqs
                                  .value
                                  ?.questions?[controller.questionIndex.value];

                              if (question == null) return SizedBox();

                              return Flexible(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: question.options.length,
                                  itemBuilder: (context, item) {
                                    final option = question.options[item];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 10,
                                      ),
                                      child: Obx(() {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: controller.isSubmited.value
                                                  ? (option == question.answer
                                                        ? Colors.green
                                                        : Colors.black)
                                                  : Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: RadioListTile(
                                            title: Text(
                                              option,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            value: option,
                                            groupValue: selected,
                                            onChanged: (value) {
                                              controller
                                                      .selectedOptionEach
                                                      .value =
                                                  option;
                                            },
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              );
                            }),
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.teal,
                                    offset: Offset(7, 7),
                                    blurStyle: BlurStyle.solid,
                                  ),
                                  BoxShadow(
                                    color: Colors.white38,
                                    offset: Offset(5, 5),
                                    blurStyle: BlurStyle.solid,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (controller
                                      .selectedOptionEach
                                      .value
                                      .isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Select atleast one Option",
                                    );
                                  } else {
                                    // Ensure selectedOptions is initialized with correct length
                                    if (controller
                                                .mcqs
                                                .value!
                                                .selectedOptions ==
                                            null ||
                                        controller
                                                .mcqs
                                                .value!
                                                .selectedOptions!
                                                .length !=
                                            controller
                                                .mcqs
                                                .value!
                                                .questions!
                                                .length) {
                                      controller.mcqs.value!.selectedOptions =
                                          List.filled(
                                            controller
                                                .mcqs
                                                .value!
                                                .questions!
                                                .length,
                                            "",
                                            growable: false,
                                          );
                                    }
                                    //storing score
                                    controller.isSubmited.value = true;
                                    controller
                                            .mcqs
                                            .value!
                                            .selectedOptions![controller
                                            .questionIndex
                                            .value] =
                                        controller.selectedOptionEach.value;

                                    //increasing score
                                    if (controller
                                            .mcqs
                                            .value!
                                            .selectedOptions![controller
                                            .questionIndex
                                            .value] ==
                                        controller
                                            .mcqs
                                            .value!
                                            .questions![controller
                                                .questionIndex
                                                .value]
                                            .answer) {
                                      controller.mcqs.value!.score++;
                                    }
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            controller.isSubmited.value
                                ? Column(
                                    spacing: 20,
                                    children: [
                                      Text(
                                        controller.selectedOptionEach.value ==
                                                controller
                                                    .mcqs
                                                    .value!
                                                    .questions![controller
                                                        .questionIndex
                                                        .value]
                                                    .answer
                                            ? "🎉 Correct 🎉"
                                            : "🤦‍♂️ Wrong 🤦‍♂️",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.teal,
                                                  offset: Offset(7, 7),
                                                  blurStyle: BlurStyle.solid,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white38,
                                                  offset: Offset(5, 5),
                                                  blurStyle: BlurStyle.solid,
                                                ),
                                              ],
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                if (controller
                                                        .questionIndex
                                                        .value <
                                                    controller
                                                            .mcqs
                                                            .value!
                                                            .questions!
                                                            .length -
                                                        1) {
                                                  controller
                                                      .questionIndex
                                                      .value++;
                                                  controller.isSubmited.value =
                                                      false;
                                                  controller
                                                          .selectedOptionEach
                                                          .value =
                                                      "";
                                                } else {
                                                  controller.pageviewController
                                                      .jumpToPage(2);
                                                }
                                              },
                                              child: Text(
                                                "Next ->",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                );
              }),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // :: Final Score ::
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2)),
                          ),
                          child: Center(
                            child: Text(
                              ":: Final Score ::",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // SCORE BOX
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 60,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Obx(() {
                                return Text(
                                  controller.mcqs.value?.score.toString() ??
                                      "0",
                                  style: TextStyle(
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                              SizedBox(height: 10),
                              Text(
                                "out of 5",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Motivation message
                        Obx(() {
                          return Text(
                            _getMessage(controller.mcqs.value?.score ?? 0),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        // ACTION BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(Icons.refresh),
                                label: Text("Retry"),
                                onPressed: () {
                                  controller.pageviewController.jumpToPage(0);
                                  controller.questionIndex.value = 0;
                                  controller.mcqs.value = null;
                                  controller.selectedOptionEach.value = "";
                                  controller.isSubmited.value = false;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(Icons.home_filled),
                                label: Text("Home"),
                                onPressed: () =>
                                    Get.offAllNamed(AppRoutes.home),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
