import 'dart:convert';

import 'package:api_demo/modules/block_chat/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchBlockchat extends GetxService {
  Future<Message?> fetchChat(String message) async {
    final response = await http.post(
      Uri.parse("https://dpvbgkk3-8000.inc1.devtunnels.ms/generate_chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      return Message.fromJson(result);
    }
    print(response.body);
    return null;
  }
}
