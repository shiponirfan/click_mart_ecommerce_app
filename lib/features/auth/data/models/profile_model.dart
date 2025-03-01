import 'package:click_mart_ecommerce_app/features/auth/data/models/user_model.dart';

class ProfileModel {
  String? token;
  UserModel? user;

  ProfileModel({this.token, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}
