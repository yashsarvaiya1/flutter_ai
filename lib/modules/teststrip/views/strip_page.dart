import 'package:api_demo/modules/teststrip/controllers/strip_controller.dart';
import 'package:api_demo/modules/teststrip/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StripPage extends StatelessWidget {
  StripPage({super.key});
  final StripController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: controller.getStripeData,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      "Test Strip",

                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 30,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Expanded(
                  flex: 11,
                  child: controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: controller.obj.length,
                          itemBuilder: (context, item) {
                            final eachitem = controller.obj[item].value!;
                            List<Color> colors = eachitem.values.map((rgb) {
                              List<String> parts = rgb.color
                                  .replaceAll(RegExp(r'[^\d,]'), '')
                                  .split(',');
                              return Color.fromRGBO(
                                int.parse(parts[0]),
                                int.parse(parts[1]),
                                int.parse(parts[2]),
                                1, // full opacity
                              );
                            }).toList();

                            return Column(
                              children: [
                                SizedBox(
                                  height: 110,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: BorderDirectional(
                                                    top: item == 0
                                                        ? BorderSide()
                                                        : BorderSide.none,
                                                    start: BorderSide(),
                                                    end: BorderSide(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                      8,
                                                      0,
                                                      0,
                                                      0,
                                                    ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      eachitem.name,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                      child: Container(
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                              border:
                                                                  Border.all(),
                                                            ),
                                                        child: Center(
                                                          child: Obx(() {
                                                            return Text(
                                                              eachitem
                                                                  .svalue
                                                                  .value,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            );
                                                          }),
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
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: BorderDirectional(
                                                    start: BorderSide(),
                                                    end: BorderSide(),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Obx(() {
                                                        return Container(
                                                          color: eachitem
                                                              .scolor
                                                              .value!,
                                                        );
                                                      }),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                    ),
                                                child: Row(
                                                  spacing: 10,
                                                  children: List.generate(
                                                    controller
                                                        .obj[item]
                                                        .value!
                                                        .values
                                                        .length,
                                                    (index) => Expanded(
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .updateSelected(
                                                                        item,
                                                                        index,
                                                                      ),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      colors[index],
                                                                  border:
                                                                      Border.all(),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        12,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              eachitem
                                                                  .values[index]
                                                                  .value,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  border: BorderDirectional(
                                                    start: BorderSide(),
                                                    end: BorderSide(),
                                                    bottom:
                                                        item ==
                                                            controller
                                                                    .obj
                                                                    .length -
                                                                1
                                                        ? BorderSide()
                                                        : BorderSide.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
