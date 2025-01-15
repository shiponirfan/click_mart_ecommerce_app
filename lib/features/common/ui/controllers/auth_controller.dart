import 'dart:convert';

import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_data_model.dart';
import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _userTokenKey = 'user-token';
  final String _userProfileKey = 'user-profile';

  String? userToken;
  ProfileModel? profileModel;

  Future<void> saveUserData(String token, ProfileModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userTokenKey, token);
    await sharedPreferences.setString(_userProfileKey, jsonEncode(model));
    await getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString(_userTokenKey);
    String? getProfile = sharedPreferences.getString(_userProfileKey);
    ProfileDataModel profileDataModel =
        ProfileDataModel.fromJson(jsonDecode(getProfile!));
    profileModel = profileDataModel.profileData;
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_userTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
