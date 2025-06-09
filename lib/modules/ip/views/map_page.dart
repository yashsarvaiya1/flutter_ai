import 'package:api_demo/modules/ip/controllers/ip_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});
  final IpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final ipMoreInfo = controller.ipmoreinfo.value;
    final latitude = ipMoreInfo?.latitude;
    final longitude = ipMoreInfo?.longitude;
    if (latitude != null && longitude != null) {
      controller.position.value = LatLng(
        double.tryParse(latitude) ?? 28.6129,
        double.tryParse(longitude) ?? 77.2295,
      );
      controller.title.value = ipMoreInfo?.city ?? "No TItle";
    } else {
      controller.position.value = LatLng(28.6129, 77.2295);
      controller.title.value = "India Gate";
    }
    return Scaffold(
      appBar: AppBar(title: Text("My Location")),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return Text("This is Map Page ${controller.ip.value}");
            }),
            Obx(() {
              return Flexible(
                child: GoogleMap(
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: controller.position.value,
                    zoom: 12,
                  ),
                  markers: controller.markers.toSet(),
                  myLocationEnabled: true,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
