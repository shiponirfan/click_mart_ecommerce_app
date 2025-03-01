import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_list_model.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool get initialProgress => _page == 1 && _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  final int _count = 15;
  int _page = 1;
  int? _lastPage;
  String _currentCategoryId = '';

  int get count => _count;

  int? get lastPage => _lastPage;

  int get page => _page;

  Future<bool> getProductListByCategory(String categoryId) async {
    bool isSuccess = false;

    if (_currentCategoryId != categoryId) {
      _currentCategoryId = categoryId;
      _page = 1;
      _productList.clear();
      _lastPage = null;
    }

    if (_lastPage != null && _page > _lastPage!) return false;

    _inProgress = true;
    update();

    Map<String, dynamic> queryParams = {
      'category': categoryId,
      'count': _count,
      'page': _page,
    };

    NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.productListUrl, queryParams: queryParams);

    if (response.isSuccess) {
      ProductListModel productListModel =
          ProductListModel.fromJson(response.responseData);

      if (_page == 1) {
        _productList = productListModel.productList!.results ?? [];
      } else {
        _productList.addAll(productListModel.productList!.results ?? []);
      }

      _lastPage = productListModel.productList!.lastPage;
      _page++;

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> refreshProductListByCategory(String categoryId) async {
    _page = 1;
    _lastPage = null;
    _productList.clear();
    return getProductListByCategory(categoryId);
  }
}
