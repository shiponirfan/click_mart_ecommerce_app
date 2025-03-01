import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/signup_screen_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/show_snackbar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  static String name = '/signup-screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignupScreenController _signupScreenController =
      SignupScreenController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const AppLogoWidget(),
              Text(
                'Singup to Click Mart',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Get started with us',
                style: textTheme.labelLarge,
              ),
              const SizedBox(
                height: 24,
              ),
              _buildForm(textTheme),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: _onPressMoveToNextScreen,
                child: const Text(
                  'Signup',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.primaryTextColor,
            ),
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: _lastNameTEController,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.primaryTextColor,
            ),
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 18,
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
            height: 18,
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
            height: 18,
          ),
          TextFormField(
            controller: _phoneTEController,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.primaryTextColor,
            ),
            decoration: const InputDecoration(
              hintText: 'Phone',
            ),
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your phone number';
              }
              if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(value!)) {
                return 'Enter valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: _cityTEController,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.primaryTextColor,
            ),
            decoration: const InputDecoration(
              hintText: 'City',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your city';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _onPressMoveToNextScreen() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userBody = {
        "first_name": _firstNameTEController.value.text.trim(),
        "last_name": _lastNameTEController.value.text.trim(),
        "email": _emailTEController.value.text.trim(),
        "password": _passwordTEController.value.text,
        "phone": _phoneTEController.value.text.trim(),
        "city": _cityTEController.value.text.trim(),
      };

      bool isSuccess = await _signupScreenController.authSignup(body: userBody);
      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, _signupScreenController.successMessage!);
          Navigator.pushNamed(
            context,
            OtpVerificationScreen.name,
            arguments: _emailTEController.value.text.trim(),
          );
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, _signupScreenController.errorMessage!, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}
