class GetIpModel {
  String? ip;

  GetIpModel({this.ip});

  factory GetIpModel.fromJson(Map<String, dynamic> json) {
    return GetIpModel(ip: json['ip']);
  }

  Map<String, dynamic> toJson() {
    return {'ip': ip};
  }

  String get label => "Your Ip is: ${(ip ?? "NO IP FOUND")}";
}
