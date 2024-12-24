import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavbarController());
  }
}
