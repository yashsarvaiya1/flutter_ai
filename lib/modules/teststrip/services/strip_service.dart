import 'dart:convert';

import 'package:api_demo/modules/teststrip/index.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StripService extends GetxService {
  //https://dummyjson.com/c/d3a7-b9b3-4f4b-9d2e
  Future<List<ItemModel?>?> fetchItems() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/c/d3a7-b9b3-4f4b-9d2e"),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      return (result as List).map((e) => ItemModel.fromJson(e)).toList();
    }
    return null;
  }
}
