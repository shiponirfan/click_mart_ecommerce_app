import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/profile_controller.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  String? _accessToken;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String? get accessToken => _accessToken;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _errorMessage = null;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.verifyOtpUrl(email, otp));
    if (response.isSuccess) {
      String token = response.responseData['data'];
      await Get.find<ProfileController>().readProfileData(token);
      _accessToken = token;
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
