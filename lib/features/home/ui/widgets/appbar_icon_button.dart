import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppbarIconButton extends StatelessWidget {
  const AppbarIconButton({
    super.key, required this.icon, required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: AppColors.secondaryTextColor.withOpacity(.2),
        child: Icon(icon),
      ),
    );
  }
}