class HostsModel {
  HostsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    required this.socialMedia,
    required this.programName,
    required this.programDay,
    required this.programTimings,
    required this.imageP,
  });
  late final int id;
  late final String name;
  late final String image;
  late final Description description;
  late final int status;
  late final SocialMedia? socialMedia;
  late final String programName;
  late final String programDay;
  late final String programTimings;
  late final String imageP;

  HostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = Description.fromJson(json['description']);
    status = json['status'];
    socialMedia = SocialMedia.fromJson(json['social_media'] ?? {});
    programName = json['program_name'];
    programDay = json['program_day'];
    programTimings = json['program_timings'];
    imageP = json['image_p'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['description'] = description.toJson();
    _data['status'] = status;
    _data['social_media'] = socialMedia!.toJson();
    _data['program_name'] = programName;
    _data['program_day'] = programDay;
    _data['program_timings'] = programTimings;
    _data['image_p'] = imageP;
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
    required this.alignment,
  });
  late final String text;
  late final String alignment;

  Data.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    alignment = json['alignment'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['alignment'] = alignment;
    return _data;
  }
}

class SocialMedia {
  SocialMedia({
    required this.facebook,
    required this.twitter,
    required this.youtube,
    required this.linkedin,
    required this.instagram,
    required this.spotify,
    required this.website,
    required this.soundcloud,
  });
  late final String facebook;
  late final String twitter;
  late final String youtube;
  late final String linkedin;
  late final String instagram;
  late final String spotify;
  late final String website;
  late final String soundcloud;

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'] ?? "null";
    twitter = json['twitter'] ?? "null";
    youtube = json['youTube'] ?? "null";
    linkedin = json['linkedIn'] ?? "null";
    instagram = json['instagram'] ?? "null";
    spotify = json['spotify'] ?? "null";
    website = json['website'] ?? "null";
    soundcloud = json['soundCloud'] ?? "null";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['facebook'] = facebook;
    _data['twitter'] = twitter;
    _data['youTube'] = youtube;
    _data['linkedIn'] = linkedin;
    _data['instagram'] = instagram;
    _data['spotify'] = spotify;
    _data['website'] = website;
    _data['soundCloud'] = soundcloud;
    return _data;
  }
}
