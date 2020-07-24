// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductListData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListData _$ProductListDataFromJson(Map<String, dynamic> json) {
  return ProductListData(
    status: json['status'] as int,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isLast: json['is_last'] as int,
  );
}

Map<String, dynamic> _$ProductListDataToJson(ProductListData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'is_last': instance.isLast,
    };
