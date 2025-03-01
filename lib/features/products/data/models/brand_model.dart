class BrandModel {
  String? sId;
  String? title;
  String? slug;
  String? icon;

  BrandModel({this.sId, this.title, this.slug, this.icon});

  BrandModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    icon = json['icon'];
  }
}