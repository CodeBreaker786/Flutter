import 'package:avalinks/models/product/Product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProductListData.g.dart';

@JsonSerializable()
class ProductListData {
  int status;
  String message;
  List<Product> data;

  @JsonKey(name: 'is_last')
  int isLast;

  ProductListData({this.status, this.message, this.data, this.isLast});

  factory ProductListData.fromJson(Map<String, dynamic> json) =>
      _$ProductListDataFromJson(json);

  Map<String, dynamic> toJson(instance) => _$ProductListDataToJson(this);
}
