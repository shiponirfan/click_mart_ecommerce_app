import 'package:click_mart_ecommerce_app/app/app_theme_data.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/email_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class ClickMart extends StatelessWidget {
  const ClickMart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        EmailVerificationScreen.route: (context) =>
            const EmailVerificationScreen(),
        OtpVerificationScreen.route: (context) => const OtpVerificationScreen(),
        CompleteProfileScreen.route: (context) => const CompleteProfileScreen(),
      },
    );
  }
}
