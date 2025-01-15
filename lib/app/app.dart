import 'package:click_mart_ecommerce_app/app/app_theme_data.dart';
import 'package:click_mart_ecommerce_app/app/controller_binder.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/email_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/splash_screen.dart';
import 'package:click_mart_ecommerce_app/features/cart/ui/screens/cart_item_screen.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/screens/category_list_screen.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/screens/home_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_details_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:click_mart_ecommerce_app/features/reviews/ui/screens/create_review_screen.dart';
import 'package:click_mart_ecommerce_app/features/reviews/ui/screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickMart extends StatelessWidget {
  const ClickMart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      initialRoute: EmailVerificationScreen.route,
      initialBinding: ControllerBinder(),
      onGenerateRoute: (RouteSettings settings) {
        late Widget route;
        if (settings.name == SplashScreen.route) {
          route = const SplashScreen();
        } else if (settings.name == EmailVerificationScreen.route) {
          route = const EmailVerificationScreen();
        } else if (settings.name == OtpVerificationScreen.route) {
          route = OtpVerificationScreen(
            email: settings.arguments as String,
          );
        } else if (settings.name == CompleteProfileScreen.route) {
          route = CompleteProfileScreen(
            accessToken: settings.arguments as String,
          );
        } else if (settings.name == HomeScreen.route) {
          route = const HomeScreen();
        } else if (settings.name == MainNavbarScreen.route) {
          route = const MainNavbarScreen();
        } else if (settings.name == CategoryListScreen.route) {
          route = const CategoryListScreen();
        } else if (settings.name == ProductListByCategoryScreen.route) {
          route = ProductListByCategoryScreen(
              categoryName: settings.arguments as String);
        } else if (settings.name == ProductDetailsScreen.route) {
          route = ProductDetailsScreen(productId: settings.arguments as String);
        } else if (settings.name == ReviewsScreen.route) {
          route = const ReviewsScreen();
        } else if (settings.name == CreateReviewScreen.route) {
          route = const CreateReviewScreen();
        } else if (settings.name == CartItemScreen.route) {
          route = const CartItemScreen();
        }
        return MaterialPageRoute(
          builder: (context) {
            return route;
          },
        );
      },
    );
  }
}
