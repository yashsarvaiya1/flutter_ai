import 'dart:convert';

import 'package:api_demo/modules/mcqtest/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchMcq extends GetxService {
  Future<McqsClass?> fetchMcqs(String topic) async {
    final res = await http.post(
      Uri.parse("https://dpvbgkk3-8000.inc1.devtunnels.ms/mcq"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'topic': topic}),
    );
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      print(result);
      return McqsClass.fromJson(result);
    }
    return null;
  }
}
