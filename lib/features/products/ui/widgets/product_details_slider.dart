import 'package:carousel_slider/carousel_slider.dart';
import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductDetailsSlider extends StatelessWidget {
  const ProductDetailsSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> _sliderChangeIndex = ValueNotifier(0);
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 230,
            viewportFraction: 1,
            onPageChanged: (currentIndex, reason) {
              _sliderChangeIndex.value = currentIndex;
            },
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: Center(
                      child: Text(
                        'Slider $i',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ));
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _sliderChangeIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: value == i ? AppColors.themeColor : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
