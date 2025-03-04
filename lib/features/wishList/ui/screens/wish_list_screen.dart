import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/no_product_found.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/single_product_card.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/features/wishList/data/models/wish_list_model.dart';
import 'package:click_mart_ecommerce_app/features/wishList/ui/controllers/wish_list_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/wishList/ui/widgets/wishlist_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static String name = '/wishlist';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final ScrollController _scrollController = ScrollController();
  final WishListScreenController controller =
      Get.find<WishListScreenController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getWishList();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300 &&
          !controller.inProgress &&
          controller.page <= (controller.lastPage ?? 1)) {
        controller.getWishList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            title: const Text('Wishlist')),
        body: RefreshIndicator(
          onRefresh: () => controller.refreshWishList(),
          child: GetBuilder<WishListScreenController>(builder: (controller) {
            if (controller.initialProgress) {
              return _buildProductByCategoryShimmerEffect();
            }
            if (controller.wishList.isEmpty) {
              return const NoProductFound();
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 170,
                    ),
                    itemCount: controller.wishList.length,
                    itemBuilder: (context, index) {
                      final WishlistModel wishlistModel =
                          controller.wishList[index];
                      return WishlistProductCard(wishlistModel: wishlistModel);
                    },
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

  void _onPop() {
    Get.find<MainNavbarController>().backToHomeScreen();
  }
}

Widget _buildProductByCategoryShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 170,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 120,
          child: Column(
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: const BorderRadius.only(
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
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 12,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    ),
  );
}
