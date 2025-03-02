import 'package:click_mart_ecommerce_app/features/cart/data/models/cart_item_model.dart';

class CartItemListModel {
  int? code;
  String? status;
  String? msg;
  CartItemPaginationModel? cartItemList;

  CartItemListModel({this.code, this.status, this.msg, this.cartItemList});

  CartItemListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    cartItemList = json['data'] != null
        ? CartItemPaginationModel.fromJson(json['data'])
        : null;
  }
}

class CartItemPaginationModel {
  List<CartItemModel>? results;
  int? total;
  int? firstPage;
  int? previous;
  int? next;
  int? lastPage;

  CartItemPaginationModel(
      {this.results,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  CartItemPaginationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <CartItemModel>[];
      json['results'].forEach((v) {
        results!.add(CartItemModel.fromJson(v));
      });
    }
    total = json['total'];
    firstPage = json['first_page'];
    previous = json['previous'];
    next = json['next'];
    lastPage = json['last_page'];
  }
}
