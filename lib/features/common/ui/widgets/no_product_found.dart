import 'package:flutter/material.dart';

class NoProductFound extends StatelessWidget {
  const NoProductFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/no-products-found.png',
        width: 120,
      ),
    );
  }
}
