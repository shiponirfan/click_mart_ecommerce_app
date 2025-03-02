import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';

class ProductDetailsModel {
  int? code;
  String? status;
  String? msg;
  ProductModel? productDetails;

  ProductDetailsModel({this.code, this.status, this.msg, this.productDetails});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    productDetails =
        json['data'] != null ? ProductModel.fromJson(json['data']) : null;
  }
}
