class BannerPaginationModel {
  List<BannerModel>? results;
  int? total;
  int? firstPage;
  int? previous;
  int? next;
  int? lastPage;

  BannerPaginationModel(
      {this.results,
        this.total,
        this.firstPage,
        this.previous,
        this.next,
        this.lastPage});

  BannerPaginationModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <BannerModel>[];
      json['results'].forEach((v) {
        results!.add(BannerModel.fromJson(v));
      });
    }
    total = json['total'];
    firstPage = json['first_page'];
    previous = json['previous'];
    next = json['next'];
    lastPage = json['last_page'];
  }
}

class BannerModel {
  String? sId;
  String? photoUrl;
  String? description;
  String? product;
  String? brand;
  dynamic category;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BannerModel(
      {this.sId,
        this.photoUrl,
        this.description,
        this.product,
        this.brand,
        this.category,
        this.createdAt,
        this.updatedAt,
        this.iV});

  BannerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photoUrl = json['photo_url'];
    description = json['description'];
    product = json['product'];
    brand = json['brand'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}