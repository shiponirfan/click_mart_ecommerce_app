import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_details_screen.dart';
import 'package:click_mart_ecommerce_app/features/wishList/data/models/wish_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.wishlistModel,
  });

  final WishlistModel wishlistModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ProductDetailsScreen.name,
            arguments: wishlistModel.product!.sId);
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
                  color: AppColors.themeColor.withValues(alpha: .1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  wishlistModel.product!.photos!.isNotEmpty
                      ? wishlistModel.product!.photos!.first
                      : 'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=',
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
                      wishlistModel.product!.title ?? '',
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
                            '\$${wishlistModel.product!.currentPrice ?? ''}',
                            style: const TextStyle(color: AppColors.themeColor),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              Text('4.7'),
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
                              CupertinoIcons.heart_fill,
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
