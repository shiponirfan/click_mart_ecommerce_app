import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSizeOptionWidget extends StatefulWidget {
  const ProductSizeOptionWidget(
      {super.key, required this.size, required this.onChange});

  final List<String> size;
  final Function(String) onChange;

  @override
  State<ProductSizeOptionWidget> createState() =>
      _ProductSizeOptionWidgetState();
}

class _ProductSizeOptionWidgetState extends State<ProductSizeOptionWidget> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _getSizeOptions(),
      ),
    );
  }

  List<Widget> _getSizeOptions() {
    List<Widget> sizeItemList = [];
    for (String size in widget.size) {
      Widget item = _getSizeItem(
          name: size,
          onPressed: () {
            _selectedSize = size;
            widget.onChange(_selectedSize!);
            setState(() {});
          },
          isSelected: _selectedSize == size);
      sizeItemList.add(item);
    }
    return sizeItemList;
  }

  Widget _getSizeItem(
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
