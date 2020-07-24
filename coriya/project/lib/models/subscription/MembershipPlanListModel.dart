import 'package:avalinks/models/subscription/MembershipPlanData.dart';

class MembershipPlanListModel {
  int status;
  String message;
  List<MembershipPlanData> data;

  MembershipPlanListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = map["data"] == null
            ? null
            : List<MembershipPlanData>.from(
                map["data"].map((it) => MembershipPlanData.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] =
        data != null ? this.data.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
