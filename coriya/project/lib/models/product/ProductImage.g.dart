// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) {
  return ProductImage(
    affiliateMediaId: json['affiliate_media_id'] as String,
    mediaType: json['media_type'] as String,
    mediaPath: json['media_path'] as String,
  );
}

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'affiliate_media_id': instance.affiliateMediaId,
      'media_type': instance.mediaType,
      'media_path': instance.mediaPath,
    };
