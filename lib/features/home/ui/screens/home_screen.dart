import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/app/assets_path.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/controllers/category_list_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/category_card_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/center_circular_progress_indicator.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/single_product_card.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/product_list_by_remark_controller.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/appbar_icon_button.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/heading_title_with_button.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/home_slider.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            _buildSearchInput(),
            const SizedBox(
              height: 10,
            ),
            const HomeSlider(),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'All Categories',
              onPressed: () {
                Get.find<MainNavbarController>().moveToCategoryListScreen();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<CategoryListController>(builder: (controller) {
              if (controller.inProgress) {
                return const CenterCircularProgressIndicator();
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getCategoryList(controller.categoryList ?? []),
                ),
              );
            }),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'Popular',
              onPressed: () {
                Get.toNamed(ProductListByCategoryScreen.route,
                    arguments: 'Popular');
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<ProductListByRemarkController>(
                tag: 'popular',
                builder: (controller) {
                  if (controller.inProgress) {
                    return const CenterCircularProgressIndicator();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductList(controller.productList ?? []),
                    ),
                  );
                }),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'Special',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<ProductListByRemarkController>(
                tag: 'special',
                builder: (controller) {
                  if (controller.inProgress) {
                    return const CenterCircularProgressIndicator();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductList(controller.productList ?? []),
                    ),
                  );
                }),
            const SizedBox(
              height: 16,
            ),
            HeadingTitleWithButton(
              title: 'New',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<ProductListByRemarkController>(
                tag: 'new',
                builder: (controller) {
                  if (controller.inProgress) {
                    return const CenterCircularProgressIndicator();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _getProductList(controller.productList ?? []),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  List<Widget> _getCategoryList(List<CategoryModel> categoryList) {
    List<Widget> list = [];
    for (int i = 0; i < categoryList.length; i++) {
      list.add(Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CategoryCardWidget(
            categoryModel: categoryList[i],
          )));
    }
    return list;
  }

  List<Widget> _getProductList(List<ProductModel> productList) {
    List<Widget> list = [];
    for (int i = 0; i < productList.length; i++) {
      list.add(Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SingleProductCard(
            productModel: productList[i],
          )));
    }
    return list;
  }

  TextFormField _buildSearchInput() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: AppColors.secondaryTextColor.withOpacity(.2),
        filled: true,
        hintText: 'Search',
        hintStyle: const TextStyle(color: AppColors.primaryTextColor),
        prefixIcon: const Icon(CupertinoIcons.search),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      title: SvgPicture.asset(
        AssetsPath.appLogoNavSvg,
        height: 28,
        fit: BoxFit.fitHeight,
      ),
      actions: [
        AppbarIconButton(
          icon: CupertinoIcons.person,
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        ),
        AppbarIconButton(
          icon: CupertinoIcons.phone,
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        ),
        AppbarIconButton(
          icon: Icons.notifications_active_outlined,
          onPressed: () {},
        ),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
