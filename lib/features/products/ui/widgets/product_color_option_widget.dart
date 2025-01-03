import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductColorOptionWidget extends StatefulWidget {
  const ProductColorOptionWidget(
      {super.key, required this.colors, required this.onChange});

  final List<String> colors;
  final Function(String) onChange;

  @override
  State<ProductColorOptionWidget> createState() =>
      _ProductColorOptionWidgetState();
}

class _ProductColorOptionWidgetState extends State<ProductColorOptionWidget> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _getColorOptions(),
      ),
    );
  }

  List<Widget> _getColorOptions() {
    List<Widget> colorItemList = [];
    for (String color in widget.colors) {
      Widget item = _getColorItem(
          name: color,
          onPressed: () {
            _selectedColor = color;
            widget.onChange(_selectedColor!);
            setState(() {});
          },
          isSelected: _selectedColor == color);
      colorItemList.add(item);
    }
    return colorItemList;
  }

  Widget _getColorItem(
      {required String name,
      required VoidCallback onPressed,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.themeColor : null,
          border: Border.all(color: AppColors.themeColor),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
