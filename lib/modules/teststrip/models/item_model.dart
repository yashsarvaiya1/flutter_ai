import 'dart:ui';

import 'package:api_demo/modules/teststrip/models/values_model.dart';
import 'package:get/state_manager.dart';

class ItemModel {
  final String id;
  final String name;
  final String unit;
  final List<ValuesModel> values;
  late final Rx<Color?> scolor;
  late final RxString svalue;

  ItemModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.values,
  }) {
    // Initialize with first value
    if (values.isNotEmpty) {
      scolor = Rx<Color?>(getColor(values[0].color));
      svalue = values[0].value.obs;
    } else {
      scolor = Rx<Color?>(null);
      svalue = ''.obs;
    }
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      unit: json['unit'],
      values: (json['values'] as List)
          .map((e) => ValuesModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'values': values.map((e) => e.toJson()).toList(),
    };
  }

  Color getColor(String s) {
    List<String> parts = s.replaceAll(RegExp(r'[^\d,]'), '').split(',');
    return Color.fromRGBO(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
      1,
    );
  }
}
