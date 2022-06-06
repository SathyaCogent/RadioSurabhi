class NewsModel {
  NewsModel({
    required this.id,
    required this.name,
    this.slug,
    required this.coverImage,
    required this.status,
    required this.shortDescription,
    required this.description,
    required this.coverImageP,
  });
  late final int id;
  late final String name;
  late final Null slug;
  late final String coverImage;
  late final int status;
  late final String shortDescription;
  late final Description description;
  late final String coverImageP;

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = null;
    coverImage = json['cover_image'];
    status = json['status'];
    shortDescription = json['short_description'];
    description = Description.fromJson(json['description']);
    coverImageP = json['cover_image_p'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['cover_image'] = coverImage;
    _data['status'] = status;
    _data['short_description'] = shortDescription;
    _data['description'] = description.toJson();
    _data['cover_image_p'] = coverImageP;
    return _data;
  }
}

class Description {
  Description({
    required this.time,
    required this.blocks,
    required this.version,
  });
  late final int time;
  late final List<Blocks> blocks;
  late final String version;

  Description.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    blocks = List.from(json['blocks']).map((e) => Blocks.fromJson(e)).toList();
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['blocks'] = blocks.map((e) => e.toJson()).toList();
    _data['version'] = version;
    return _data;
  }
}

class Blocks {
  Blocks({
    required this.data,
    required this.type,
  });
  late final Data data;
  late final String type;

  Blocks.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['type'] = type;
    return _data;
  }
}

class Data {
  Data({
    required this.text,
    this.alignment,
    this.level,
  });
  late final String text;
  late String? alignment;
  late int? level;

  Data.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    alignment = json.containsKey('alignment') ? json['alignment'] : null;
    level = json.containsKey('level') ? json['level'] : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['alignment'] = alignment;
    _data['level'] = level;
    return _data;
  }
}
