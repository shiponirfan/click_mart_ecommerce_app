import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_details_list_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  ProductDetailsModel? _productDetails;

  ProductDetailsModel? get productDetails => _productDetails;

  Future<bool> getProductDetails(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    _productDetails = null;
    update();
    NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.productDetailsByIdUrl(productId));
    if (response.isSuccess) {
      ProductDetailsListModel productDetailsListModel =
          ProductDetailsListModel.fromJson(response.responseData);
      _productDetails = productDetailsListModel.productDetails?[0];
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
