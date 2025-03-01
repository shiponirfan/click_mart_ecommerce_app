import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_data_model.dart';
import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_model.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  String? _successMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  Future<bool> authLogin(
      {required String email, required String password}) async {
    Map<String, String> body = {"email": email, "password": password};

    bool isSuccess = false;
    _errorMessage = null;
    _inProgress = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(Urls.loginUrl, body: body);
    if (response.isSuccess) {
      ProfileDataModel profileDataModel =
          ProfileDataModel.fromJson(response.responseData);
      ProfileModel? profileModel = profileDataModel.profileData;
      await Get.find<AuthController>()
          .saveUserData(profileModel!.token!, profileModel.user!);
      _successMessage = profileDataModel.msg;
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
