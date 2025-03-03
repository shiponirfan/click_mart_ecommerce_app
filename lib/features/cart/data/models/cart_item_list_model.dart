import 'package:click_mart_ecommerce_app/features/cart/data/models/cart_item_model.dart';

class CartItemListModel {
  int? code;
  String? status;
  String? msg;
  CartItemPaginationModel? cartItemData;

  CartItemListModel({this.code, this.status, this.msg, this.cartItemData});

  CartItemListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    cartItemData = json['data'] != null ? CartItemPaginationModel.fromJson(json['data']) : null;
  }
}
