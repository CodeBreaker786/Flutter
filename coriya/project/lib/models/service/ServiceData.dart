import 'package:avalinks/models/service/ServiceMedia.dart';
import 'package:avalinks/models/service/category/ServiceCategory.dart';

class ServiceData {
  String service_id;
  String business_name;
  String service_price;
  String service_description;
  String service_address;
  String service_website;
  String service_email;
  String service_phone;
  String service_working_hour;
  String service_status;
  ServiceCategory selected_category;
  List<ServiceMedia> media;

  ServiceData.fromJsonMap(Map<String, dynamic> map)
      : service_id = map["service_id"],
        business_name = map["business_name"],
        service_price = map["service_price"],
        service_description = map["service_description"],
        service_address = map["service_address"],
        service_website = map["service_website"],
        service_email = map["service_email"],
        service_phone = map["service_phone"],
        service_working_hour = map["service_working_hour"] == null
            ? ''
            : map["service_working_hour"],
        service_status = map["service_status"],
        selected_category = map["selected_category"] == null
            ? null
            : ServiceCategory.fromJson(map["selected_category"]),
        media = map["media"] == null
            ? null
            : List<ServiceMedia>.from(
                map["media"].map((it) => ServiceMedia.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = service_id;
    data['business_name'] = business_name;
    data['service_price'] = service_price;
    data['service_description'] = service_description;
    data['service_address'] = service_address;
    data['service_website'] = service_website;
    data['service_email'] = service_email;
    data['service_phone'] = service_phone;
    data['service_working_hour'] = service_working_hour;
    data['service_status'] = service_status;
    data['selected_category'] = selected_category.toJson();
    data['media'] =
        media != null ? this.media.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
