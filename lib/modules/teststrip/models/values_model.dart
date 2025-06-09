class ValuesModel {
  final String color;
  final String value;

  ValuesModel({required this.color, required this.value});

  factory ValuesModel.fromJson(Map<String, dynamic> json) {
    return ValuesModel(color: json['color'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'color': color, 'value': value};
  }
}
