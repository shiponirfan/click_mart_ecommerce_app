import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/complete_profile_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/email_verification_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/profile_controller.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/controllers/category_list_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/home_slider_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/product_list_by_remark_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_details_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_list_by_category_controller.dart';
import 'package:click_mart_ecommerce_app/services/netwotk_caller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavbarController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => OtpVerificationController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => CompleteProfileController());
    Get.lazyPut(() => HomeSliderController());
    Get.lazyPut(() => CategoryListController());
    Get.lazyPut(() => ProductListByRemarkController());
    Get.lazyPut(() => ProductListByCategoryController());
    Get.lazyPut(() => ProductDetailsController());
  }
}
