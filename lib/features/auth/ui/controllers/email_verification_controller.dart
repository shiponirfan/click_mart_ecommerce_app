import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyEmail(String email) async {
    bool isSuccess = false;
    _errorMessage = null;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.verifyEmailUrl(email));
    if (response.isSuccess) {
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
