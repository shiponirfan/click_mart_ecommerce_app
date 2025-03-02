import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';

class CartItemModel {
  String? sId;
  ProductModel? product;
  String? user;
  int? quantity;
  List<String>? color;
  List<String>? size;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CartItemModel(
      {this.sId,
        this.product,
        this.user,
        this.quantity,
        this.color,
        this.size,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    user = json['user'];
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}