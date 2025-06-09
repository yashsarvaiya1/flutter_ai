class IpInfoModel {
  String? ip;
  String? city;
  String? region;
  String? latitude;
  String? longitude;
  String? org;
  String? postal;
  String? timezone;

  IpInfoModel({
    this.ip,
    this.city,
    this.region,
    this.latitude,
    this.longitude,
    this.org,
    this.postal,
    this.timezone,
  });

  factory IpInfoModel.fromJson(Map<String, dynamic> json) {
    List<String> loc_split = json['loc'].split(',');
    return IpInfoModel(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      latitude: loc_split[0],
      longitude: loc_split[1],
      org: json['org'],
      postal: json['postal'],
      timezone: json['timezone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      "city": city,
      "region": region,
      'loc': '${latitude ?? ''},${longitude ?? ''}',
      "org": org,
      "postal": postal,
      "timezone": timezone,
    };
  }
}
