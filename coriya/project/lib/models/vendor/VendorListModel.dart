import 'package:avalinks/models/vendor/VendorData.dart';

class VendorListModel {
  int status;
  String message;
  List<VendorData> data;
  int is_last;

  VendorListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map["data"] == null
            ? null
            : List<VendorData>.from(
                map["data"].map((it) => VendorData.fromJsonMap(it))),
        is_last = map["is_last"];

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
