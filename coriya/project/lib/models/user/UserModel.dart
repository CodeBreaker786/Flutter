import 'package:avalinks/models/user/UserData.dart';

class UserModel {
  int status;
  String message;
  UserData data;

  UserModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map['data'] == null ? null : UserData.fromJsonMap(map["data"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> model = new Map<String, dynamic>();
    model['status'] = status;
    model['message'] = message;
    model['data'] = data == null ? null : data.toJson();
    return model;
  }
}
