import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/signup_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/login_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:click_mart_ecommerce_app/features/cart/ui/controllers/cart_item_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/controllers/category_list_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/auth_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/home_slider_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/add_to_cart_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_details_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_list_by_category_controller.dart';
import 'package:click_mart_ecommerce_app/features/wishList/ui/controllers/wish_list_screen_controller.dart';
import 'package:click_mart_ecommerce_app/services/network_caller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavbarController());
    Get.lazyPut(() => NetworkCaller());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => OtpVerificationController());
    Get.lazyPut(() => SignupScreenController());
    Get.lazyPut(() => HomeSliderController());
    Get.lazyPut(() => CategoryListController());
    Get.lazyPut(() => ProductDetailsController());
    Get.lazyPut(() => ProductListByCategoryController());
    Get.lazyPut(() => AddToCartController());
    Get.lazyPut(() => CartItemScreenController());
    Get.lazyPut(() => WishListScreenController());
  }
}
