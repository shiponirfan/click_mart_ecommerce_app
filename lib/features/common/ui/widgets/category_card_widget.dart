import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.themeColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.computer,
            size: 40,
            color: AppColors.themeColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Electronics',
          style: TextStyle(
            color: AppColors.themeColor,
          ),
        )
      ],
    );
  }
}
