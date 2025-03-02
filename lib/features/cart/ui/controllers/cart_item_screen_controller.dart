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

  List<CartItemModel> _cartItemModel = [];

  List<CartItemModel> get cartItemModel => _cartItemModel;

  final int _count = 10;
  int _page = 1;
  int? _lastPage;

  Future<bool> getCartItemList() async {
    String? accessToken = Get.find<AuthController>().userToken;
    if (_lastPage != null && _page > _lastPage!) return false;

    _inProgress = true;
    update();

    Map<String, dynamic> queryParams = {
      'count': _count,
      'page': _page,
    };

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.cartUrl,
        queryParams: queryParams,
        accessToken: accessToken);

    if (response.isSuccess) {
      CartItemListModel cartItemListModel =
          CartItemListModel.fromJson(response.responseData);

      if (_page == 1) {
        _cartItemModel.clear();
      }

      _cartItemModel.addAll(cartItemListModel.cartItemList?.results ?? []);
      _lastPage = cartItemListModel.cartItemList?.lastPage;

      _page++;

      _errorMessage = null;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }

  Future<bool> refreshCartItemList() async {
    _page = 1;
    _lastPage = null;
    return getCartItemList();
  }
}
