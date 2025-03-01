import 'package:click_mart_ecommerce_app/app/urls.dart';
import 'package:click_mart_ecommerce_app/features/home/data/models/banner_list_model.dart';
import 'package:click_mart_ecommerce_app/features/home/data/models/banner_model.dart';
import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<BannerModel>? _bannerList;

  List<BannerModel>? get bannerList => _bannerList;

  Future<bool> getBannerSlide() async {
    bool isSuccess = false;
    _inProgress = true;
    _bannerList = null;
    update();
    NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(Urls.homeSliderUrl);
    if (response.isSuccess) {
      BannerListModel bannerListModel =
          BannerListModel.fromJson(response.responseData);
      _bannerList = bannerListModel.bannerList!.results;
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
