import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';

class ProductDetailsListModel {
  String? msg;
  List<ProductDetailsModel>? productDetails;

  ProductDetailsListModel({this.msg, this.productDetails});

  ProductDetailsListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productDetails = <ProductDetailsModel>[];
      json['data'].forEach((v) {
        productDetails!.add(ProductDetailsModel.fromJson(v));
      });
    }
  }
}

class ProductDetailsModel {
  int? id;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? des;
  String? color;
  String? size;
  int? productId;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  ProductDetailsModel(
      {this.id,
      this.img1,
      this.img2,
      this.img3,
      this.img4,
      this.des,
      this.color,
      this.size,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    des = json['des'];
    color = json['color'];
    size = json['size'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }
}
