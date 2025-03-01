import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';

class ProductListModel {
  int? code;
  String? status;
  String? msg;
  ProductPaginationModel? productList;

  ProductListModel({this.code, this.status, this.msg, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    productList = json['data'] != null
        ? ProductPaginationModel.fromJson(json['data'])
        : null;
  }
}
