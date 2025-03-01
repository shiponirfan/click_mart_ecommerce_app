import 'package:carousel_slider/carousel_slider.dart';
import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/controllers/home_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> sliderChangeIndex = ValueNotifier(0);
    return GetBuilder<HomeSliderController>(builder: (controller) {
      if (controller.inProgress) {
        return _buildShimmerEffect(context);
      }
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 164,
              viewportFraction: 0.9,
              autoPlay: true,
              onPageChanged: (currentIndex, reason) {
                sliderChangeIndex.value = currentIndex;
              },
            ),
            items: controller.bannerList?.map((banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            banner.photoUrl ?? '',
                          ),
                          fit: BoxFit.cover,
                        )),
                    // child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       banner.description ?? '',
                    //       style: const TextStyle(
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 8,
          ),
          ValueListenableBuilder(
            valueListenable: sliderChangeIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < controller.bannerList!.length; i++)
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: value == i
                            ? AppColors.themeColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.secondaryTextColor),
                      ),
                    )
                ],
              );
            },
          )
        ],
      );
    });
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 164,
          viewportFraction: 0.9,
        ),
        items: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(8),
            ),
          )
        ],
      ),
    );
  }
}
