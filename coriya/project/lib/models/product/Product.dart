import 'package:avalinks/models/product/ProductImage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable()
class Product{
  @JsonKey(name: 'affiliate_id')
  String affiliateId;

  @JsonKey(name: 'product_name')
  String productName;

  @JsonKey(name: 'product_details')
  String productDetails;

  @JsonKey(name: 'product_price')
  String productPrice;

  @JsonKey(name: 'product_afflilated_link')
  String productAfflilatedLink;

  @JsonKey(name: 'product_post_date')
  String productPostDate;

  @JsonKey(name: 'product_status')
  String productStatus;

  @JsonKey(name: 'product_images')
  List<ProductImage> productImages;

  Product({this.affiliateId, this.productName, this.productDetails,
    this.productPrice, this.productAfflilatedLink, this.productPostDate,
    this.productStatus, this.productImages});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson(instance) => _$ProductToJson(this);
}