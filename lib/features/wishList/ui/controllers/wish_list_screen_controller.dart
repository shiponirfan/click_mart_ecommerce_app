import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/features/wishList/data/models/wish_list_data_model.dart';
import 'package:click_mart_ecommerce_app/features/wishList/data/models/wish_list_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:get/get.dart';

class WishListScreenController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool get initialProgress => _page == 1 && _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<WishlistModel> _wishList = [];

  List<WishlistModel> get wishList => _wishList;

  final int _count = 10;
  int _page = 0;
  int? _lastPage;

  int get page => _page;

  int? get lastPage => _lastPage;

  Future<bool> getWishList() async {
    await Get.find<AuthController>().getUserData();
    String? accessToken = Get.find<AuthController>().userToken;
    bool isSuccess = false;

    if (_lastPage != null && _page >= _lastPage!) return false;

    _page++;
    _inProgress = true;
    update();

    Map<String, dynamic> queryParams = {
      'count': _count,
      'page': _page,
    };

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.wishlistUrl,
      queryParams: queryParams,
      accessToken: accessToken,
    );

    if (response.isSuccess) {
      WishlistDataModel wishlistDataModel =
          WishlistDataModel.fromJson(response.responseData);

      if (_page == 1) {
        _wishList = wishlistDataModel.wishlistData?.results ?? [];
      } else {
        _wishList.addAll(wishlistDataModel.wishlistData?.results ?? []);
      }

      _lastPage = wishlistDataModel.wishlistData?.lastPage;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> refreshWishList() async {
    _page = 0;
    _lastPage = null;
    _wishList.clear();
    return getWishList();
  }
}
