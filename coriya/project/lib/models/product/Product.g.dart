// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    affiliateId: json['affiliate_id'] as String,
    productName: json['product_name'] as String,
    productDetails: json['product_details'] as String,
    productPrice: json['product_price'] as String,
    productAfflilatedLink: json['product_afflilated_link'] as String,
    productPostDate: json['product_post_date'] as String,
    productStatus: json['product_status'] as String,
    productImages: (json['product_images'] as List)
        ?.map((e) =>
            e == null ? null : ProductImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'affiliate_id': instance.affiliateId,
      'product_name': instance.productName,
      'product_details': instance.productDetails,
      'product_price': instance.productPrice,
      'product_afflilated_link': instance.productAfflilatedLink,
      'product_post_date': instance.productPostDate,
      'product_status': instance.productStatus,
      'product_images': instance.productImages,
    };
