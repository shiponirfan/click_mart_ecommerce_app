import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_color_option_widget.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_details_slider.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_quantity_button.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_size_option_widget.dart';
import 'package:click_mart_ecommerce_app/features/reviews/ui/screens/reviews_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static String route = '/product/product-details';
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ProductDetailsSlider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductTitleSection(textTheme),
                        Text(
                          'Color',
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ProductColorOptionWidget(
                          colors: const ['Red', 'Green', 'Blue', 'Yellow'],
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
                          size: const ['S', 'M', 'L', 'X', 'XXL'],
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
                          '''Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator''',
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
          _buildAddToCartButton(textTheme)
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(.1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Price',
                style: textTheme.titleMedium,
              ),
              Text(
                '\$100',
                style:
                    textTheme.titleLarge?.copyWith(color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(MainNavbarScreen.route);
                  Get.find<MainNavbarController>().moveToCartItemScreen();
                },
                child: const Text('Add To Cart')),
          )
        ],
      ),
    );
  }

  Row _buildProductTitleSection(TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Happy New Year Special Deal Save 30%',
                maxLines: 2,
                style: textTheme.titleLarge,
              ),
              _buildReviewSection(),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ProductQuantityButton(
          onChange: (quantity) {
            print(quantity);
          },
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Row(
      children: [
        const Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text('4.8'),
          ],
        ),
        TextButton(
            onPressed: () {
              Get.toNamed(ReviewsScreen.route);
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
}
