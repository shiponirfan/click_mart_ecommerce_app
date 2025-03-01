import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';

class CategoryListModel {
  int? code;
  String? status;
  String? msg;
  CategoryPaginationModel? categoryList;

  CategoryListModel({this.code, this.status, this.msg, this.categoryList});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    categoryList = json['data'] != null
        ? CategoryPaginationModel.fromJson(json['data'])
        : null;
  }
}
