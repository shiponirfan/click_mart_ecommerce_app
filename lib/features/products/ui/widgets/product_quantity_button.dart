import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/material.dart';

class ProductQuantityButton extends StatefulWidget {
  const ProductQuantityButton({super.key, required this.onChange});

  final Function(int) onChange;

  @override
  State<ProductQuantityButton> createState() => _ProductQuantityButtonState();
}

class _ProductQuantityButtonState extends State<ProductQuantityButton> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(
          icon: Icons.remove,
          onTap: () {
            if (_quantity > 1) {
              _quantity--;
              widget.onChange(_quantity);
              setState(() {});
            }
          },
        ),
        SizedBox(
          width: 34,
          child: Text(
            '$_quantity',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        _buildIconButton(
          icon: Icons.add,
          onTap: () {
            if (_quantity < 20) {
              _quantity++;
              widget.onChange(_quantity);
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget _buildIconButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
