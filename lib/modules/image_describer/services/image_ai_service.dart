import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageAiService extends GetxService {
  Future<String> fetchdescription(File file) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://dpvbgkk3-8000.inc1.devtunnels.ms/describe"),
    );
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['description'];
    }
    return "Description Not Generated";
  }
}
