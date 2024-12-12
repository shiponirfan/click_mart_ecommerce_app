import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  static String route = 'complete-profile-screen';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              children: <Widget>[
                const AppLogoWidget(),
                Text(
                  'Complete Profile',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 5,),
                Text(
                  'Get started with us with your details',
                  style: textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
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
                  controller: _mobileTEController,
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  keyboardType: TextInputType.number,
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
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: _addressTEController,
                  maxLines: 3,
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryTextColor,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Shipping Address',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your shipping address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: _onPressMoveToNextScreen,
                  child: const Text(
                    'Complete',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressMoveToNextScreen() {
    // if (_formKey.currentState!.validate()) {};
    Navigator.pushNamed(context, OtpVerificationScreen.route);
  }
}
