class WishlistPaginationModel {
  List<WishlistModel>? results;
  int? total;
  int? firstPage;
  int? previous;
  int? next;
  int? lastPage;

  WishlistPaginationModel(
      {this.results,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  WishlistPaginationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <WishlistModel>[];
      json['results'].forEach((v) {
        results!.add(WishlistModel.fromJson(v));
      });
    }
    total = json['total'];
    firstPage = json['first_page'];
    previous = json['previous'];
    next = json['next'];
    lastPage = json['last_page'];
  }
}

class WishlistModel {
  String? sId;
  Product? product;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  WishlistModel(
      {this.sId,
      this.product,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Product {
  String? sId;
  String? title;
  String? brand;
  List<String>? categories;
  String? slug;
  String? metaDescription;
  String? description;
  List<String>? photos;
  List<String>? colors;
  List<String>? sizes;
  List<String>? tags;
  int? regularPrice;
  int? currentPrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
      this.title,
      this.brand,
      this.categories,
      this.slug,
      this.metaDescription,
      this.description,
      this.photos,
      this.colors,
      this.sizes,
      this.tags,
      this.regularPrice,
      this.currentPrice,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    brand = json['brand'];
    categories = json['categories'].cast<String>();
    slug = json['slug'];
    metaDescription = json['meta_description'];
    description = json['description'];
    photos = json['photos'].cast<String>();
    if (json['colors'] != null) {
      colors = <String>[];
      json['colors'].forEach((v) {
        colors!.add(v);
      });
    }
    if (json['sizes'] != null) {
      sizes = <String>[];
      json['sizes'].forEach((v) {
        sizes!.add(v);
      });
    }
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add(v);
      });
    }
    regularPrice = json['regular_price'];
    currentPrice = json['current_price'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
