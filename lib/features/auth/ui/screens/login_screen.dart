import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/login_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/show_snackbar_message.dart';
import 'package:click_mart_ecommerce_app/features/home/ui/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginScreenController _loginScreenController =
      Get.find<LoginScreenController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 114,
                ),
                const AppLogoWidget(),
                Text(
                  'Welcome Back',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Please Enter Your Email & Password',
                  style: textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _emailTEController,
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your email address';
                    }
                    if (!EmailValidator.validate(value!)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordTEController,
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<LoginScreenController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: _onPressLogin,
                    child: const Text(
                      'Login',
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLogin() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await _loginScreenController.authLogin(
          email: _emailTEController.value.text.trim(),
          password: _passwordTEController.value.text);
      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(
            context,
            _loginScreenController.successMessage!,
          );
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.name, (route) => false);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, _loginScreenController.errorMessage!, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
