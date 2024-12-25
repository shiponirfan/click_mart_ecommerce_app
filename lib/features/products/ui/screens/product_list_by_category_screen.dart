import 'package:click_mart_ecommerce_app/features/common/ui/widgets/single_product_card.dart';
import 'package:flutter/material.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.categoryName});

  static String route = '/product-list-by-category-screen';
  final String categoryName;

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 170),
        itemBuilder: (context, index) {
          return const SingleProductCard();
        },
        itemCount: 16,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
