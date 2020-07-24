import 'package:json_annotation/json_annotation.dart';

part 'ServiceCategory.g.dart';

@JsonSerializable()
class ServiceCategory {
  @JsonKey(name: 'service_category_id')
  String serviceCategoryId;

  @JsonKey(name: 'parent_category_id')
  String parentCategoryId;

  @JsonKey(name: 'service_category_name')
  String serviceCategoryName;

  @JsonKey(name: 'service_category_status')
  String serviceCategoryStatus;

  @JsonKey(name: 'created_date')
  String createdDate;

  List<ServiceCategory> children;

  ServiceCategory(
      {this.serviceCategoryId,
      this.parentCategoryId,
      this.serviceCategoryName,
      this.serviceCategoryStatus,
      this.createdDate,
      this.children});

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCategoryToJson(this);
}
