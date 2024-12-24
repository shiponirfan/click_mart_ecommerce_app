import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class HeadingTitleWithButton extends StatelessWidget {
  const HeadingTitleWithButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.headingTextColor,
          ),
        ),
        InkWell(
          onTap: onPressed,
          splashColor: Colors.transparent,
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.themeColor,
            ),
          ),
        ),
      ],
    );
  }
}
