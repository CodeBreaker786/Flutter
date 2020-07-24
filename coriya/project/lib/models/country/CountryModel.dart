import 'package:avalinks/models/country/CountryData.dart';

class CountryModel {
  int status;
  String message;
  List<CountryData> data;

  CountryModel.fromJsonMap(Map<String, dynamic> map)
      : status = map["status"],
        message = map["message"],
        data = List<CountryData>.from(
            map["data"].map((it) => CountryData.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['data'] =
        data != null ? this.data.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
