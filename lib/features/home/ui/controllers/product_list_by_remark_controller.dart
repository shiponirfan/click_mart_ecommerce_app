import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_list_model.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class ProductListByRemarkController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<ProductModel>? _productList;

  List<ProductModel>? get productList => _productList;

  Future<bool> getProductListByRemark(String remark) async {
    bool isSuccess = false;
    _inProgress = true;
    _productList = null;
    update();
    NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.listProductByRemarkUrl(remark));
    if (response.isSuccess) {
      ProductListModel productListModel =
          ProductListModel.fromJson(response.responseData);
      _productList = productListModel.productList;
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
