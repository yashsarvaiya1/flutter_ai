import 'package:api_demo/core/app.dart';
import 'package:api_demo/modules/ip/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IpPage extends StatelessWidget {
  IpPage({super.key});
  final IpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              "Get Info About your IP",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Obx(() {
              return (controller.flag.value
                  ? Text(
                      controller.ipobj.value!.label,
                      style: TextStyle(fontSize: 20),
                    )
                  : SizedBox());
            }),
            ElevatedButton(
              onPressed: () => controller.getip(),
              child: Text("Fetch IP"),
            ),
            Obx(() {
              var obj = controller.ipmoreinfo.value ?? IpInfoModel();
              return Column(
                children: [
                  (controller.moreflag.value
                      ? Column(
                          children: [
                            Text("loc : ${obj.city}"),
                            Text("loc : ${obj.ip}"),
                            Text("loc : ${obj.latitude}"),
                            Text("loc : ${obj.longitude}"),
                            Text("loc : ${obj.org}"),
                            Text("loc : ${obj.postal}"),
                            Text("loc : ${obj.timezone}"),
                          ],
                        )
                      : SizedBox()),
                  (controller.flag.value
                      ? ElevatedButton(
                          onPressed: () => controller.getMoreInfo(),
                          child: Text("GetMore Info"),
                        )
                      : SizedBox()),

                  (controller.moreflag.value
                      ? ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.mappage),
                          child: Text("Show MAP"),
                        )
                      : SizedBox()),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
