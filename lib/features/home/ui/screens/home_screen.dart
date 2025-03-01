import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/app/assets_path.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/controllers/category_list_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/category_card_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/no_product_found.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/single_product_card.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/appbar_icon_button.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/heading_title_with_button.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/widgets/home_slider.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_list_by_category_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String name = '/home';

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
                return _buildCategoryShimmerEffect();
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
                Get.toNamed(ProductListByCategoryScreen.name, arguments: {
                  'categoryName': 'Popular',
                  'categoryId': '67c35af85e8a445235de197b',
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<ProductListByCategoryController>(
                tag: 'Popular',
                builder: (controller) {
                  if (controller.initialProgress) {
                    return _buildProductByRemarkShimmerEffect();
                  }
                  if (controller.productList!.isEmpty) {
                    return const NoProductFound();
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
              onPressed: () {
                Get.toNamed(ProductListByCategoryScreen.name, arguments: {
                  'categoryName': 'Special',
                  'categoryId': '67c35b395e8a445235de197e',
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<ProductListByCategoryController>(
                tag: 'Special',
                builder: (controller) {
                  if (controller.initialProgress) {
                    return _buildProductByRemarkShimmerEffect();
                  }
                  if (controller.productList!.isEmpty) {
                    return const NoProductFound();
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
              onPressed: () {
                Get.toNamed(ProductListByCategoryScreen.name, arguments: {
                  'categoryName': 'New',
                  'categoryId': '67ae2865149a96f2acf9ad72',
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<ProductListByCategoryController>(
                tag: 'New',
                builder: (controller) {
                  if (controller.initialProgress) {
                    return _buildProductByRemarkShimmerEffect();
                  }
                  if (controller.productList!.isEmpty) {
                    return const NoProductFound();
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
        fillColor: AppColors.secondaryTextColor.withValues(alpha: .2),
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

  Widget _buildCategoryShimmerEffect() {
    List<Widget> getCategorySimmerEffectList() {
      List<Widget> list = [];
      for (int i = 0; i < 10; i++) {
        list.add(Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 70,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            )));
      }
      return list;
    }

    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: getCategorySimmerEffectList(),
          ),
        ));
  }

  Widget _buildProductByRemarkShimmerEffect() {
    List<Widget> getProductShimmerEffectList() {
      List<Widget> list = [];
      for (int i = 0; i < 10; i++) {
        list.add(Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 120,
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 12,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
      }
      return list;
    }

    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: getProductShimmerEffectList(),
          ),
        ));
  }
}
