class AddToCartModel {
  String? product;
  String? user;
  int? quantity;
  List<String>? color;
  List<String>? size;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AddToCartModel(
      {this.product,
      this.user,
      this.quantity,
      this.color,
      this.size,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    user = json['user'];
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
