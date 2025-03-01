import 'package:click_mart_ecommerce_app/features/common/ui/widgets/no_product_found.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/single_product_card.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_list_by_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  static String name = '/product-list-by-category';
  final String categoryName;
  final String categoryId;

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final ProductListByCategoryController controller =
      Get.find<ProductListByCategoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getProductListByCategory(widget.categoryId);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300 &&
          !controller.inProgress) {
        controller.getProductListByCategory(widget.categoryId);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            controller.refreshProductListByCategory(widget.categoryId),
        child:
            GetBuilder<ProductListByCategoryController>(builder: (controller) {
          if (controller.initialProgress) {
            return _buildProductByCategoryShimmerEffect();
          }
          if (controller.productList.isEmpty) {
            return const NoProductFound();
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 170,
                  ),
                  itemBuilder: (context, index) {
                    ProductModel productModel = controller.productList[index];
                    return SingleProductCard(
                      productModel: productModel,
                    );
                  },
                  itemCount: controller.productList.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    );
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
      itemBuilder: (context, index) {
        return SizedBox(
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
        );
      },
      itemCount: 12,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    ),
  );
}
