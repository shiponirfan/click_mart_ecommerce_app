import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/brand_model.dart';

class ProductPaginationModel {
  List<ProductModel>? results;
  int? total;
  int? firstPage;
  int? previous;
  int? next;
  int? lastPage;

  ProductPaginationModel(
      {this.results,
      this.total,
      this.firstPage,
      this.previous,
      this.next,
      this.lastPage});

  ProductPaginationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ProductModel>[];
      json['results'].forEach((v) {
        results!.add(ProductModel.fromJson(v));
      });
    }
    total = json['total'];
    firstPage = json['first_page'];
    previous = json['previous'];
    next = json['next'];
    lastPage = json['last_page'];
  }
}

class ProductModel {
  String? sId;
  String? title;
  BrandModel? brand;
  List<CategoryModel>? categories;
  String? slug;
  String? metaDescription;
  String? description;
  List<dynamic>? photos;
  List<dynamic>? colors;
  List<dynamic>? sizes;
  List<dynamic>? tags;
  int? regularPrice;
  int? currentPrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  bool? inCart;
  bool? inWishlist;

  ProductModel(
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
      this.inCart,
      this.inWishlist});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
    slug = json['slug'];
    metaDescription = json['meta_description'];
    description = json['description'];
    if (json['photos'] != null) {
      photos = <dynamic>[];
      json['photos'].forEach((v) {
        photos!.add(v);
      });
    }
    if (json['colors'] != null) {
      colors = <dynamic>[];
      json['colors'].forEach((v) {
        colors!.add(v);
      });
    }
    if (json['sizes'] != null) {
      sizes = <dynamic>[];
      json['sizes'].forEach((v) {
        sizes!.add(v);
      });
    }
    if (json['tags'] != null) {
      tags = <dynamic>[];
      json['tags'].forEach((v) {
        tags!.add(v);
      });
    }
    regularPrice = json['regular_price'];
    currentPrice = json['current_price'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
  }
}
