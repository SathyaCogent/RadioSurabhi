class ArchivesModels {
  ArchivesModels({
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.status,
    required this.coverImage,
    required this.coverImageP,
  });
  late final int id;
  late final String name;
  late final String videoUrl;
  late final int status;
  late final String coverImage;
  late final String coverImageP;

  ArchivesModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    videoUrl = json['video_url'];
    status = json['status'];
    coverImage = json['cover_image'];
    coverImageP = json['cover_image_p'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['video_url'] = videoUrl;
    _data['status'] = status;
    _data['cover_image'] = coverImage;
    _data['cover_image_p'] = coverImageP;
    return _data;
  }
}
