import 'package:click_mart_ecommerce_app/features/wishList/data/models/wish_list_model.dart';

class WishlistDataModel {
  int? code;
  String? status;
  String? msg;
  WishlistPaginationModel? wishlistData;

  WishlistDataModel({this.code, this.status, this.msg, this.wishlistData});

  WishlistDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    wishlistData = json['data'] != null
        ? WishlistPaginationModel.fromJson(json['data'])
        : null;
  }
}
