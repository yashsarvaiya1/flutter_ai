import 'package:api_demo/modules/ip/index.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IpController extends GetxController {
  final ipobj = Rxn<GetIpModel>();
  final ipmoreinfo = Rxn<IpInfoModel>();
  final ip = "".obs;
  final flag = false.obs;
  final moreflag = false.obs;
  final GetipService fetchip = Get.find();

  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final Rx<LatLng> position = Rx<LatLng>(LatLng(0.0, 0.0));
  final title = "".obs;
  final RxSet<Marker> markers = <Marker>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(ip.value);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    addMarker(position.value, title.value);
  }

  void addMarker(LatLng position, String title) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: position,
      infoWindow: InfoWindow(title: title),
    );
    markers.add(marker);
  }

  Future<void> getip() async {
    ipobj.value = await fetchip.fetchIp() ?? GetIpModel(ip: "");
    if (ipobj.value != null) {
      flag.value = true;
      ip.value = ipobj.value!.ip ?? "";
    } else {
      flag.value = false;
    }
  }

  Future<void> getMoreInfo() async {
    ipmoreinfo.value = await fetchip.fethMoreInfo(ip.value);
    print(ipmoreinfo.value?.ip ?? "NO DATA");
    ipmoreinfo.value != null ? moreflag.value = true : moreflag.value = false;
  }
}
