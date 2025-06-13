import 'package:api_demo/modules/mcqtest/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class McqController extends GetxController {
  var isloading = false.obs;
  late final pageviewController = PageController();
  var mcqs = Rxn<McqsClass>();
  final FetchMcq service = Get.find();
  final textcontroller = TextEditingController();
  final pageIndex = 0.obs;
  var questionIndex = 0.obs;
  var selectedOptionEach = "".obs;
  var isSubmited = false.obs;

  Future<void> getMcq() async {
    isloading.value = true;
    final data = await service.fetchMcqs(textcontroller.text);
    if (data != null) {
      mcqs.value = data;
    }
    isloading.value = false;
  }
}
