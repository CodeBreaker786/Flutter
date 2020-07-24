import 'package:json_annotation/json_annotation.dart';

part 'ProductImage.g.dart';

@JsonSerializable()
class ProductImage {
  @JsonKey(name: 'affiliate_media_id')
  String affiliateMediaId;

  @JsonKey(name: 'media_type')
  String mediaType;

  @JsonKey(name: 'media_path')
  String mediaPath;

  ProductImage({this.affiliateMediaId, this.mediaType, this.mediaPath});

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);

  Map<String, dynamic> toJson(instance) => _$ProductImageToJson(this);
}
