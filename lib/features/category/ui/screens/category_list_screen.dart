import 'package:click_mart_ecommerce_app/features/common/ui/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Text'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return FittedBox(child: const CategoryCardWidget());
        },
        itemCount: 16,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
