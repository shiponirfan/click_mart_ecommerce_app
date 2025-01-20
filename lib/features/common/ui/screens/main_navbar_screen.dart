import 'package:click_mart_ecommerce_app/features/cart/ui/screens/cart_item_screen.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/controllers/category_list_controller.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/screens/category_list_screen.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/home_slider_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/product_list_by_remark_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/screens/home_screen.dart';
import 'package:click_mart_ecommerce_app/features/wishList/ui/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavbarScreen extends StatefulWidget {
  const MainNavbarScreen({super.key});

  static String route = 'main-navbar-screen';

  @override
  State<MainNavbarScreen> createState() => _MainNavbarScreenState();
}

class _MainNavbarScreenState extends State<MainNavbarScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(),
    const CartItemScreen(),
    const WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeSliderController>().getBannerSlide();
    Get.find<CategoryListController>().getCategoryList();
    Get.put(ProductListByRemarkController(), tag: 'Popular')
        .getProductListByRemark('popular');
    Get.put(ProductListByRemarkController(), tag: 'Special')
        .getProductListByRemark('special');
    Get.put(ProductListByRemarkController(), tag: 'New')
        .getProductListByRemark('new');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavbarController>(builder: (controller) {
      return Scaffold(
        body: _screens[controller.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex,
          onDestinationSelected: (value) {
            controller.changeIndex(value);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Category'),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(
                icon: Icon(Icons.card_giftcard), label: 'Wish'),
          ],
        ),
      );
    });
  }
}
