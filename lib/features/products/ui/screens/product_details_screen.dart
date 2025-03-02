import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/controllers/product_details_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_color_option_widget.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_details_slider.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_quantity_button.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_size_option_widget.dart';
import 'package:click_mart_ecommerce_app/features/reviews/ui/screens/reviews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static String name = '/product/product-details';
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Get.find<ProductDetailsController>()
              .getProductDetails(widget.productId);
        },
        child: GetBuilder<ProductDetailsController>(builder: (controller) {
          if (controller.inProgress) {
            return _buildShimmerEffects();
          }
          if (controller.errorMessage != null) {
            return Text(controller.errorMessage!);
          }
          ProductModel productModel = controller.productDetails!;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductDetailsSlider(
                        images: [
                          productModel.photos!.isNotEmpty
                              ? productModel.photos!.first
                              : 'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=',
                          productModel.photos!.isNotEmpty
                              ? productModel.photos!.first
                              : 'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=',
                          productModel.photos!.isNotEmpty
                              ? productModel.photos!.first
                              : 'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=',
                          productModel.photos!.isNotEmpty
                              ? productModel.photos!.first
                              : 'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=',
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProductTitleSection(
                                textTheme, productModel.title ?? '', 5),
                            Text(
                              'Color',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ProductColorOptionWidget(
                              colors: productModel.colors != null
                                  ? productModel.colors!
                                      .cast<String>() // Cast to List<String>
                                  : ['0xff445544'],
                              onChange: (String color) {},
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Size',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ProductSizeOptionWidget(
                              size: productModel.sizes != null
                                  ? productModel.sizes!
                                      .cast<String>() // Cast to List<String>
                                  : ['M', 'XL'],
                              onChange: (String size) {},
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Description',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              productModel.description ?? '',
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildAddToCartButton(
                  textTheme, productModel.currentPrice.toString())
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAddToCartButton(TextTheme textTheme, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withValues(alpha: .1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: textTheme.titleMedium,
              ),
              Text(
                '\$$price',
                style:
                    textTheme.titleLarge?.copyWith(color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(MainNavbarScreen.name);
                  Get.find<MainNavbarController>().moveToCartItemScreen();
                },
                child: const Text('Add To Cart')),
          )
        ],
      ),
    );
  }

  Widget _buildProductTitleSection(
      TextTheme textTheme, String title, int reviewRating) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                style: textTheme.titleLarge,
              ),
              _buildReviewSection(reviewRating),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ProductQuantityButton(
          onChange: (quantity) {
            // TODO: Add Quantity Option
          },
        ),
      ],
    );
  }

  Widget _buildReviewSection(int reviewRating) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text('$reviewRating'),
          ],
        ),
        TextButton(
            onPressed: () {
              Get.toNamed(ReviewsScreen.name);
            },
            child: const Text('Reviews')),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.themeColor,
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Icon(
            CupertinoIcons.heart,
            size: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerEffects() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 230,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 150,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 80,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 80,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 90,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
          ],
        ));
  }
}
