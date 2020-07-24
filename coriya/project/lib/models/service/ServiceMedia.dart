class ServiceMedia {
  String media_id;
  String media_type;
  String media_path;

  ServiceMedia.fromJsonMap(Map<String, dynamic> map)
      : media_id = map["media_id"],
        media_type = map["media_type"],
        media_path = map["media_path"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_id'] = media_id;
    data['media_type'] = media_type;
    data['media_path'] = media_path;
    return data;
  }
}
