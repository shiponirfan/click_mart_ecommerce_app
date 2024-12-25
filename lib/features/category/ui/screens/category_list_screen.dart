import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/category_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  static String route = '/category-screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: _onPop,
          ),
          title: const Text('Category Text'),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return const FittedBox(child: CategoryCardWidget());
          },
          itemCount: 16,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  void _onPop() {
    Get.find<MainNavbarController>().backToHomeScreen();
  }
}
