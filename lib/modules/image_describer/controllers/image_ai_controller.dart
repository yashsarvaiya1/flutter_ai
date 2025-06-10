import 'dart:io';

import 'package:api_demo/modules/image_describer/index.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageAiController extends GetxController {
  var isloading = false.obs;
  var description = "Description Will Be Here.".obs;
  final picker = ImagePicker();
  var file = Rxn<File>();
  final ImageAiService service = Get.find();

  Future<void> pick_file() async {
    final pickedfile = await picker.pickImage(source: ImageSource.camera);
    if (pickedfile == null) {
      return;
    }
    file.value = File(pickedfile.path);
  }

  Future<void> get_description() async {
    if (file.value == null) {
      Get.snackbar("Error", "No image Selected.");
      return;
    }
    isloading.value = true;
    description.value = await service.fetchdescription(file.value!);

    isloading.value = false;
  }

  void reset() {
    file.value = null;
    description.value = "Description Will Be Here.";
  }
}
