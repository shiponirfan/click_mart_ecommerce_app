import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_data_model.dart';
import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_model.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  bool _shouldNavigateToProfileScreen = false;

  bool get shouldNavigateToProfileScreen => _shouldNavigateToProfileScreen;

  Future<bool> readProfileData(String token) async {
    bool isSuccess = false;
    _errorMessage = null;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.readProfileUrl, accessToken: token);
    if (response.isSuccess) {
      if (response.responseData['data'] == null) {
        _shouldNavigateToProfileScreen = true;
        update();
      } else {
        ProfileDataModel profileDataModel =
            ProfileDataModel.fromJson(response.responseData);
        ProfileModel? profileModel = profileDataModel.profileData;
        await Get.find<AuthController>().saveUserData(token, profileModel!);
        _shouldNavigateToProfileScreen = false;
        update();
      }
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
