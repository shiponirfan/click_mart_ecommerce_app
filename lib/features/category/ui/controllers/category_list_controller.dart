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

  final int _count = 10;
  int _page = 0;
  int? _lastPage;

  Future<bool> getCategoryList() async {
    _page++;

    if (_lastPage != null && _page > _lastPage!) return false;

    bool isSuccess = false;
    _inProgress = true;
    _categoryList = null;
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
      _categoryList = categoryListModel.categoryList!.results;

      if (categoryListModel.categoryList!.lastPage != null) {
        _lastPage = categoryListModel.categoryList!.lastPage;
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
