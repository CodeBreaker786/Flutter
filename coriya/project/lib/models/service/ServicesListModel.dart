import 'package:avalinks/models/service/ServiceData.dart';

class ServicesListModel {
  int status;
  String message;
  List<ServiceData> data;
  int is_last;

  ServicesListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map["data"] == null
            ? null
            : List<ServiceData>.from(
                map["data"].map((it) => ServiceData.fromJsonMap(it))),
        is_last = map["is_last"] == null ? 0 : map["is_last"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] =
        data != null ? this.data.map((v) => v.toJson()).toList() : null;
    data['is_last'] = is_last;
    return data;
  }
}
