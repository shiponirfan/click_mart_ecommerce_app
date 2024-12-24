import 'package:click_mart_ecommerce_app/app/app_theme_data.dart';
import 'package:click_mart_ecommerce_app/app/controller_binder.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/email_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/splash_screen.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/screens/home_screen.dart';
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
      initialRoute: SplashScreen.route,
      initialBinding: ControllerBinder(),
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        EmailVerificationScreen.route: (context) =>
            const EmailVerificationScreen(),
        OtpVerificationScreen.route: (context) => const OtpVerificationScreen(),
        CompleteProfileScreen.route: (context) => const CompleteProfileScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        MainNavbarScreen.route: (context) => const MainNavbarScreen(),
      },
    );
  }
}
