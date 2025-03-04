import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:click_mart_ecommerce_app/features/cart/ui/controllers/cart_item_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/controllers/main_navbar_controller.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/show_snackbar_message.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_details_screen.dart';
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
  final ScrollController _scrollController = ScrollController();
  final CartItemScreenController _cartItemScreenController =
      Get.find<CartItemScreenController>();

  @override
  void initState() {
    super.initState();
    _cartItemScreenController.getCartItemList();

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 300 &&
          !_cartItemScreenController.inProgress &&
          (_cartItemScreenController.lastPage == null ||
              _cartItemScreenController.page <=
                  _cartItemScreenController.lastPage!)) {
        _cartItemScreenController.getCartItemList();
      }
    });
  }

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _onPop();
      },
      child: RefreshIndicator(
        onRefresh: () {
          return _cartItemScreenController.refreshCartItemList();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: _onPop,
            ),
            title: const Text('Cart Items'),
          ),
          body: GetBuilder<CartItemScreenController>(builder: (controller) {
            if (controller.initialProgress) {
              return const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (controller.cartItemList.isEmpty) {
              return const Center(
                child: Text("No items in cart"),
              );
            }

            for (CartItemModel cartItem in controller.cartItemList) {
              totalPrice += cartItem.product?.currentPrice ?? 0;
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    itemCount: controller.cartItemList.length,
                    itemBuilder: (context, index) {
                      CartItemModel cartItem = controller.cartItemList[index];

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
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(ProductDetailsScreen.name,
                                        arguments: cartItem.product!.sId);
                                  },
                                  child: Image.network(
                                    cartItem.product?.photos?.isNotEmpty == true
                                        ? cartItem.product!.photos!.first
                                        : 'https://media.istockphoto.com/id/1180410208/vector/landscape-image-gallery-with-the-photos-stack-up.jpg?s=612x612&w=0&k=20&c=G21-jgMQruADLPDBk7Sf1vVvCEtPiJD3Rf39AeB95yI=',
                                    width: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(ProductDetailsScreen.name,
                                            arguments: cartItem.product!.sId);
                                      },
                                      child: Text(
                                        cartItem.product?.title ?? '',
                                        style: textTheme.titleSmall?.copyWith(
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 1,
                                      ),
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
                                      '\$${cartItem.product?.currentPrice ?? ''}',
                                      style: textTheme.titleLarge?.copyWith(
                                          color: AppColors.themeColor),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      bool isSuccess =
                                          await _cartItemScreenController
                                              .deleteCartItem(
                                                  cartItem.sId ?? '');
                                      if (isSuccess) {
                                        showSnackBarMessage(
                                          context,
                                          _cartItemScreenController
                                                  .successMessage ??
                                              'Something Is Wrong',
                                        );
                                      }
                                    },
                                    icon: const Icon(CupertinoIcons.trash),
                                  ),
                                  ProductQuantityButton(
                                    defaultQuantity: cartItem.quantity,
                                    onChange: (quantity) async {
                                      bool isSuccess =
                                          await _cartItemScreenController
                                              .updateCartItemQuantity(
                                                  cartItem.sId ?? '', quantity);
                                      if (isSuccess) {
                                        showSnackBarMessage(
                                          context,
                                          _cartItemScreenController
                                                  .successMessage ??
                                              'Something Is Wrong',
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: controller.inProgress,
                  child: const LinearProgressIndicator(),
                ),
                _buildCheckoutButton(textTheme),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withValues(alpha: .1),
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
                '\$$totalPrice',
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
