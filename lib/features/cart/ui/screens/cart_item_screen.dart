import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/widgets/product_quantity_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemScreen extends StatefulWidget {
  const CartItemScreen({super.key});

  static String name = '/cart-item';

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: _onPop,
          ),
          title: const Text('Reviews'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/shoe.png',
                              width: 100,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'New Year Special Shoe',
                                  style: textTheme.titleSmall?.copyWith(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                                const Wrap(
                                  children: [
                                    Text('Color: Red'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text('Size: X'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '\$100',
                                  style: textTheme.titleLarge
                                      ?.copyWith(color: AppColors.themeColor),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(CupertinoIcons.trash),
                              ),
                              ProductQuantityButton(
                                onChange: (quantity) {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
            _buildCheckoutButton(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(.1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Total Price',
                style: textTheme.titleMedium,
              ),
              Text(
                '\$1005',
                style:
                    textTheme.titleLarge?.copyWith(color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Checkout')),
          )
        ],
      ),
    );
  }

  void _onPop() {
    Get.find<MainNavbarController>().backToHomeScreen();
  }
}
