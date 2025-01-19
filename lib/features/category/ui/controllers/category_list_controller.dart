import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_list_model.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CategoryModel>? _categoryList;

  List<CategoryModel>? get categoryList => _categoryList;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    _categoryList = null;
    update();
    NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.categoryListUrl);
    if (response.isSuccess) {
      CategoryListModel categoryListModel =
          CategoryListModel.fromJson(response.responseData);
      _categoryList = categoryListModel.categoryList;
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
