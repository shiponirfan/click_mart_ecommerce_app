import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  static String route = 'otp-verification-screen';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
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
              children: [
                const SizedBox(
                  height: 114,
                ),
                const AppLogoWidget(),
                Text(
                  'Enter OTP Code',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(height: 5,),
                Text(
                  'A 4 Digit OTP Code has been Sent',
                  style: textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  appContext: context,
                  keyboardType: TextInputType.number,
                  controller: _otpTEController,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(6),
                      activeColor: AppColors.themeColor,
                      inactiveColor: AppColors.themeColor,
                      selectedColor: AppColors.themeColor), // Pass it here,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: _onPressMoveToNextScreen,
                  child: const Text(
                    'Next',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                      text: 'This code will expire in ',
                      style: textTheme.labelLarge,
                      children: const [
                        TextSpan(
                            text: '120s',
                            style: TextStyle(
                              color: AppColors.themeColor,
                            ))
                      ]),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text('Resend Code', style: textTheme.labelLarge))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressMoveToNextScreen() {
    // if (_formKey.currentState!.validate()) {};
    Navigator.pushNamed(context, CompleteProfileScreen.route);
  }
}