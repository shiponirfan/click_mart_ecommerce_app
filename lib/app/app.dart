import 'package:click_mart_ecommerce_app/app/app_theme_data.dart';
import 'package:click_mart_ecommerce_app/app/controller_binder.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/signup_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/login_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/splash_screen.dart';
import 'package:click_mart_ecommerce_app/features/cart/ui/screens/cart_item_screen.dart';
import 'package:click_mart_ecommerce_app/features/category/ui/screens/category_list_screen.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/screens/home_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_details_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:click_mart_ecommerce_app/features/products/ui/screens/product_list_by_remark_screen.dart';
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
      initialRoute: SplashScreen.name,
      initialBinding: ControllerBinder(),
      onGenerateRoute: (RouteSettings settings) {
        late Widget route;
        if (settings.name == SplashScreen.name) {
          route = const SplashScreen();
        } else if (settings.name == LoginScreen.name) {
          route = const LoginScreen();
        } else if (settings.name == OtpVerificationScreen.name) {
          route = OtpVerificationScreen(
            email: settings.arguments as String,
          );
        } else if (settings.name == SignupScreen.name) {
          route = const SignupScreen();
        } else if (settings.name == HomeScreen.name) {
          route = const HomeScreen();
        } else if (settings.name == MainNavbarScreen.name) {
          route = const MainNavbarScreen();
        } else if (settings.name == CategoryListScreen.name) {
          route = const CategoryListScreen();
        } else if (settings.name == ProductListByCategoryScreen.name) {
          Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          route = ProductListByCategoryScreen(
            categoryName: args['categoryName'],
            categoryId: args['categoryId'],
          );
        } else if (settings.name == ProductDetailsScreen.name) {
          route = ProductDetailsScreen(productId: settings.arguments as String);
        } else if (settings.name == ReviewsScreen.name) {
          route = const ReviewsScreen();
        } else if (settings.name == CreateReviewScreen.name) {
          route = const CreateReviewScreen();
        } else if (settings.name == CartItemScreen.name) {
          route = const CartItemScreen();
        } else if (settings.name == ProductListByRemarkScreen.name) {
          route = ProductListByRemarkScreen(
            remark: settings.arguments as String,
          );
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
