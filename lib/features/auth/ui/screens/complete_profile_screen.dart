import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/auth/data/models/profile_model.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/complete_profile_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/show_snackbar_message.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, required this.accessToken});

  static String route = 'complete-profile-screen';
  final String accessToken;

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
  final CompleteProfileController _completeProfileController =
      CompleteProfileController();

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
                'Complete Profile',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Get started with us with your details',
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
                  'Complete',
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
            controller: _mobileTEController,
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.primaryTextColor,
            ),
            decoration: const InputDecoration(
              hintText: 'Mobile',
            ),
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your mobile number';
              }
              if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(value!)) {
                return 'Enter valid mobile number';
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
        ],
      ),
    );
  }

  void _onPressMoveToNextScreen() async {
    if (_formKey.currentState!.validate()) {
      String fullName =
          '${_firstNameTEController.text.trim()} ${_lastNameTEController.text.trim()}';
      Map<String, dynamic> body = ProfileModel(
        cusName: fullName,
        cusAdd: _addressTEController.text.trim(),
        cusCity: _cityTEController.text.trim(),
        cusState: _cityTEController.text.trim(),
        cusPostcode: '0',
        cusCountry: 'Bangladesh',
        cusPhone: _mobileTEController.text.trim(),
        cusFax: _mobileTEController.text.trim(),
        shipName: fullName,
        shipAdd: _addressTEController.text.trim(),
        shipCity: _cityTEController.text.trim(),
        shipState: _cityTEController.text.trim(),
        shipPostcode: '0',
        shipCountry: 'Bangladesh',
        shipPhone: _mobileTEController.text.trim(),
      ).toJson();

      bool isSuccess = await _completeProfileController.createProfile(
          body: body, token: widget.accessToken);
      if (isSuccess) {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainNavbarScreen.route, (predicate) => false);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, _completeProfileController.errorMessage!, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _addressTEController.dispose();
    super.dispose();
  }
}
