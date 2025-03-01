import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/products/data/models/product_model.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ProductDetailsScreen.name, arguments: '1');
      },
      child: SizedBox(
        width: 120,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  productModel.image ?? '',
                  width: 88,
                  height: 88,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      productModel.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${productModel.price ?? ''}',
                            style: const TextStyle(color: AppColors.themeColor),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              Text('${productModel.star ?? ''}'),
                            ],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Icon(
                              CupertinoIcons.heart,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
