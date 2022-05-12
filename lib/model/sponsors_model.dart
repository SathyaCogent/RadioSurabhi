class SponsorsModel {
  SponsorsModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.status,
    required this.url,
    required this.logoP,
  });
  late final int id;
  late final String name;
  late final String logo;
  late final int status;
  late final String url;
  late final String logoP;

  SponsorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    status = json['status'];
    url = json['url'];
    logoP = json['logo_p'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['logo'] = logo;
    _data['status'] = status;
    _data['url'] = url;
    _data['logo_p'] = logoP;
    return _data;
  }
}
