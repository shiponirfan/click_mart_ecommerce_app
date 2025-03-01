import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_list_model.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool get initialProgress => _page == 1 && _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CategoryModel>? _categoryList;

  List<CategoryModel>? get categoryList => _categoryList;

  final int _count = 30;
  int _page = 0;
  int? _lastPage;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _page++;
    if (_lastPage != null && _page > _lastPage!) return false;

    _inProgress = true;
    _categoryList = _page == 1 ? [] : _categoryList;
    update();

    Map<String, dynamic> queryParams = {
      'count': _count,
      'page': _page,
    };

    NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.categoryListUrl, queryParams: queryParams);

    if (response.isSuccess) {
      CategoryListModel categoryListModel =
          CategoryListModel.fromJson(response.responseData);

      if (_page == 1) {
        _categoryList = categoryListModel.categoryList!.results;
      } else {
        _categoryList!.addAll(categoryListModel.categoryList!.results ?? []);
      }

      _lastPage = categoryListModel.categoryList!.lastPage;

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> refreshCategoryList() async {
    _page = 0;
    _lastPage = null;
    _categoryList?.clear();
    return getCategoryList();
  }
}
