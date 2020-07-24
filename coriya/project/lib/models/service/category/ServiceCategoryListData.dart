import 'package:avalinks/models/service/category/ServiceCategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ServiceCategoryListData.g.dart';

@JsonSerializable()
class ServiceCategoryListData {
  int status;
  String message;
  List<ServiceCategory> data;

  ServiceCategoryListData({this.status, this.message, this.data});

  factory ServiceCategoryListData.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryListDataFromJson(json);

  Map<String, dynamic> toJson(instance) =>
      _$ServiceCategoryListDataToJson(this);
}
