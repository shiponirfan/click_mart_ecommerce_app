import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/add_to_cart_item_model.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? _successMessage;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  AddToCartItemModel? _addToCartModel;

  AddToCartItemModel? get addToCartModel => _addToCartModel;

  Future<bool> addToCartItem(String productId) async {
    String? accessToken = Get.find<AuthController>().userToken;

    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> body = {"product": productId};

    NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.cartUrl, body: body, accessToken: accessToken);

    if (response.isSuccess) {
      AddToCartItemModel addToCartItemModel =
          AddToCartItemModel.fromJson(response.responseData);
      _successMessage = addToCartItemModel.msg;
      isSuccess = true;
      update();
    } else {
      AddToCartItemModel addToCartItemModel =
          AddToCartItemModel.fromJson(response.responseData ?? {});
      _successMessage = addToCartItemModel.msg;
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
