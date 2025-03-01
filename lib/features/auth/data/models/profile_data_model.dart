import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_model.dart';

class ProfileDataModel {
  int? code;
  String? status;
  String? msg;
  ProfileModel? profileData;

  ProfileDataModel({this.code, this.status, this.msg, this.profileData});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
    profileData = json['data'] != null ? ProfileModel.fromJson(json['data']) : null;
  }
}
