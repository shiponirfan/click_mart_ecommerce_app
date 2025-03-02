import 'package:click_mart_ecommerce_app/features/products/data/models/add_to_cart_model.dart';

class AddToCartItemModel {
  int? code;
  String? status;
  String? msg;
  AddToCartModel? addToCartData;

  AddToCartItemModel({this.code, this.status, this.msg, this.addToCartData});

  AddToCartItemModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    addToCartData =
        json['data'] != null ? AddToCartModel.fromJson(json['data']) : null;
  }
}
