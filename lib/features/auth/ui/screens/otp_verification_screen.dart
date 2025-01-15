import 'dart:async';

import 'package:click_mart_ecommerce_app/app/app_colors.dart';
import 'package:click_mart_ecommerce_app/app/app_constants.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/otp_verification_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/controllers/profile_controller.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:click_mart_ecommerce_app/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/screens/main_navbar_screen.dart';
import 'package:click_mart_ecommerce_app/features/common/ui/widgets/show_snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  static String route = 'otp-verification-screen';
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final OtpVerificationController _otpVerificationController =
      OtpVerificationController();

  final RxInt _remingTime = AppConstants.resendOtpTimeOutTimeInSec.obs;
  final RxBool _enableResendCodeButton = false.obs;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _startResendCodeTimer();
  }

  void _startResendCodeTimer() {
    _enableResendCodeButton.value = false;
    _remingTime.value = AppConstants.resendOtpTimeOutTimeInSec;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (time) {
        _remingTime.value--;
        if (_remingTime.value == 0) {
          time.cancel();
          _enableResendCodeButton.value = true;
        }
      },
    );
  }

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
                const SizedBox(
                  height: 5,
                ),
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
                  validator: (value) {
                    if (_otpTEController.text.length < 6) {
                      return 'Enter your OTP';
                    }
                    return null;
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(6),
                      activeColor: AppColors.themeColor,
                      inactiveColor: AppColors.themeColor,
                      selectedColor: AppColors.themeColor),
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
                Obx(() => _enableResendCodeButton.value == false
                    ? RichText(
                        text: TextSpan(
                            text: 'This code will expire in ',
                            style: textTheme.labelLarge,
                            children: [
                              TextSpan(
                                  text: '${_remingTime.value}s',
                                  style: const TextStyle(
                                    color: AppColors.themeColor,
                                  ))
                            ]),
                      )
                    : TextButton(
                        onPressed: _startResendCodeTimer,
                        child: Text('Resend Code',
                            style: textTheme.labelLarge
                                ?.copyWith(color: AppColors.themeColor)))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressMoveToNextScreen() async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await _otpVerificationController.verifyOtp(
          widget.email, _otpTEController.text);
      if (isSuccess) {
        if (Get.find<ProfileController>().shouldNavigateToProfileScreen) {
          if (mounted) {
            Navigator.pushNamed(context, CompleteProfileScreen.route,
                arguments: _otpVerificationController.accessToken);
          }
        } else {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(context, MainNavbarScreen.route, (predicate)=> false);
          }
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, _otpVerificationController.errorMessage!, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
