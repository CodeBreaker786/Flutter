import 'package:avalinks/models/subscription/PaymentCallbackData.dart';

class PaymentCallbackModel {
  int status;
  String message;
  PaymentCallbackData data;

  PaymentCallbackModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map["data"] == null
            ? null
            : PaymentCallbackData.fromJsonMap(map["data"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = new Map<String, dynamic>();
    dataMap['status'] = status;
    dataMap['message'] = message;
    dataMap['data'] = data == null ? null : data.toJson();
    return dataMap;
  }
}
