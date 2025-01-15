import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/email_verification_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/show_snackbar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static String route = 'email-verification';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

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
                  'Please Enter Your Email Address',
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
                    hintText: 'Email Address',
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
                  height: 24,
                ),
                GetBuilder<EmailVerificationController>(builder: (controller) {
                  if (controller.inProgress) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: _onPressMoveToNextScreen,
                    child: const Text(
                      'Next',
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

  void _onPressMoveToNextScreen() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await _emailVerificationController
          .verifyEmail(_emailTEController.text.trim());
      if (isSuccess) {
        if (mounted) {
          Navigator.pushNamed(context, OtpVerificationScreen.route,
              arguments: _emailTEController.text.trim());
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, _emailVerificationController.errorMessage!, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
