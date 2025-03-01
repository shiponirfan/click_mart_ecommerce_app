import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/controllers/category_list_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/category_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  static String name = '/category';

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ScrollController _scrollController = ScrollController();
  final CategoryListController _categoryListController =
      Get.find<CategoryListController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.extentAfter < 300) {
      _categoryListController.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _onPop();
      },
      child: RefreshIndicator(
        onRefresh: () {
          return Get.find<CategoryListController>().getCategoryList();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: _onPop,
            ),
            title: const Text('Category'),
          ),
          body: GetBuilder<CategoryListController>(builder: (controller) {
            if (controller.initialProgress) {
              return _buildShimmerEffect();
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel =
                          controller.categoryList![index];
                      return FittedBox(
                          child: CategoryCardWidget(
                        categoryModel: categoryModel,
                      ));
                    },
                    itemCount: controller.categoryList?.length ?? 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                  ),
                ),
                Visibility(
                  visible: controller.inProgress,
                  child: const LinearProgressIndicator(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Column(
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
            );
          },
          itemCount: 12,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ));
  }

  void _onPop() {
    Get.find<MainNavbarController>().backToHomeScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
