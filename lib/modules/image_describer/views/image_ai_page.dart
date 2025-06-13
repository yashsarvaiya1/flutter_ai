import 'package:api_demo/core/app.dart';
import 'package:api_demo/modules/image_describer/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class ImageAiPage extends StatelessWidget {
  ImageAiPage({super.key});

  final ImageAiController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "I M A G E ! T E X T",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        spacing: 10,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Obx(() {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: controller.file.value == null
                                    ? IconButton(
                                        onPressed: controller.pick_file,
                                        icon: Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 50,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.file(
                                          controller.file.value!,
                                        ),
                                      ),
                              );
                            }),
                          ),
                          Expanded(
                            flex: 3,
                            child: Obx(() {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      controller.description.value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(() {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.teal[200],
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: controller.isloading.value
                                    ? Center(child: CircularProgressIndicator())
                                    : TextButton(
                                        onPressed: controller.get_description,
                                        child: Text(
                                          "Generate Description",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 30.0,
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: controller.reset,
                            icon: Icon(Icons.refresh, size: 30),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.teal[200],
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () => Get.offAllNamed(AppRoutes.home),
                            icon: Icon(Clarity.home_solid),
                          ),
                        ),
                      ),
                    ],
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
