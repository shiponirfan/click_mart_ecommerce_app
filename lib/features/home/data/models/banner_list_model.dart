import 'package:click_mart_ecommerce_app/features/home/data/models/banner_model.dart';

class BannerListModel {
  int? code;
  String? status;
  String? msg;
  BannerPaginationModel? bannerList;

  BannerListModel({this.code, this.status, this.msg, this.bannerList});

  BannerListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    bannerList = json['data'] != null
        ? BannerPaginationModel.fromJson(json['data'])
        : null;
  }
}
