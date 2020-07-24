class ForgotPasswordModel {
  int status;
  String message;

  ForgotPasswordModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> model = new Map<String, dynamic>();
    model['status'] = status;
    model['message'] = message;
    return model;
  }
}
