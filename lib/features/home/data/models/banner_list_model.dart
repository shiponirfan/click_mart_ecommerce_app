import 'package:click_mart_ecommerce_app/features/home/data/models/banner_model.dart';

class BannerListModel {
  String? msg;
  List<BannerModel>? bannerList;

  BannerListModel({this.msg, this.bannerList});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      bannerList = <BannerModel>[];
      json['data'].forEach((v) {
        bannerList!.add(BannerModel.fromJson(v));
      });
    }
  }
}
