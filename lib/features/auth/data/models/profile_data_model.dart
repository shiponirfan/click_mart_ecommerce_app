import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_model.dart';

class ProfileDataModel {
  String? msg;
  ProfileModel? profileData;

  ProfileDataModel({this.msg, this.profileData});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    profileData =
        json['data'] != null ? ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (profileData != null) {
      data['data'] = profileData!.toJson();
    }
    return data;
  }
}
