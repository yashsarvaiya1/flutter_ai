import 'dart:convert';

import 'package:api_demo/modules/ip/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetipService extends GetxController {
  Future<GetIpModel?> fetchIp() async {
    final response = await http.get(
      Uri.parse("https://api.ipify.org?format=json"),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return GetIpModel.fromJson(result);
    }
    return null;
  }

  Future<IpInfoModel?> fethMoreInfo(String ip) async {
    final response = await http.get(Uri.parse("https://ipinfo.io/$ip/geo"));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return IpInfoModel.fromJson(result);
    }
    return null;
  }
}
