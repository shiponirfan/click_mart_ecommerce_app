import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/category/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

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
          child: Image.network(
            categoryModel.categoryImg ?? '',
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          categoryModel.categoryName ?? '',
          style: const TextStyle(
            color: AppColors.themeColor,
          ),
        )
      ],
    );
  }
}
