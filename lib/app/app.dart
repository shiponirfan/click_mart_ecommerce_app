import 'package:click_mart_ecommerce_app/app/app_theme_data.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
