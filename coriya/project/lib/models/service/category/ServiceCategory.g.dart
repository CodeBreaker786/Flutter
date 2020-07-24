// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) {
  return ServiceCategory(
    serviceCategoryId: json['service_category_id'] as String,
    parentCategoryId: json['parent_category_id'] as String,
    serviceCategoryName: json['service_category_name'] as String,
    serviceCategoryStatus: json['service_category_status'] as String,
    createdDate: json['created_date'] as String,
    children: json.containsKey('children')
        ? (json['children'] as List)
            ?.map((e) => e == null
                ? null
                : ServiceCategory.fromJson(e as Map<String, dynamic>))
            ?.toList()
        : [],
  );
}

Map<String, dynamic> _$ServiceCategoryToJson(ServiceCategory instance) =>
    <String, dynamic>{
      'service_category_id': instance.serviceCategoryId,
      'parent_category_id': instance.parentCategoryId,
      'service_category_name': instance.serviceCategoryName,
      'service_category_status': instance.serviceCategoryStatus,
      'created_date': instance.createdDate,
      'children': instance.children,
    };
