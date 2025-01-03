import 'package:get/get.dart';

class MainNavbarController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    if (index == _selectedIndex) {
      return;
    }
    _selectedIndex = index;
    update();
  }

  void backToHomeScreen() {
    changeIndex(0);
  }

  void moveToCategoryListScreen() {
    changeIndex(1);
  }

  void moveToCartItemScreen() {
    changeIndex(2);
  }
}
