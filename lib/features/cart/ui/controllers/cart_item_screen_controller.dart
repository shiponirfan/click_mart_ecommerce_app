import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/cart/data/models/cart_item_list_model.dart';
import 'package:click_mart_ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:get/get.dart';

class CartItemScreenController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool get initialProgress => _page == 1 && _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CartItemModel> _cartItemList = [];

  List<CartItemModel> get cartItemList => _cartItemList;

  final int _count = 10;
  int _page = 1;
  int? _lastPage;

  int get count => _count;

  int? get lastPage => _lastPage;

  int get page => _page;

  Future<bool> getCartItemList({bool isRefresh = false}) async {
    await Get.find<AuthController>().getUserData();
    String? accessToken = Get.find<AuthController>().userToken;
    if (accessToken == null || accessToken.isEmpty) {
      _errorMessage = "Authentication token is missing.";
      update();
      return false;
    }

    if (isRefresh) {
      _page = 1;
      _lastPage = null;
      _cartItemList.clear();
    }

    if (_lastPage != null && _page > _lastPage!) {
      return false;
    }

    _inProgress = true;
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.cartUrl,
      queryParams: {
        'count': _count,
        'page': _page,
      },
      accessToken: accessToken,
    );

    bool isSuccess = false;

    if (response.isSuccess) {
      CartItemListModel cartItemListModel =
          CartItemListModel.fromJson(response.responseData);

      if (_page == 1) {
        _cartItemList = cartItemListModel.cartItemData?.results ?? [];
      } else {
        _cartItemList.addAll(cartItemListModel.cartItemData?.results ?? []);
      }

      _lastPage = cartItemListModel.cartItemData?.lastPage;
      _page++;

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> refreshCartItemList() async {
    return getCartItemList(isRefresh: true);
  }
}
