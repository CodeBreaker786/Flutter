class DeleteServiceModel {
  int status;
  String message;
  bool data;

  DeleteServiceModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map["data"] == null ? null : map["data"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
