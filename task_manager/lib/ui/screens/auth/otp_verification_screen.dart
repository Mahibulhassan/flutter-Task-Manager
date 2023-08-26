import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screeen.dart';
import 'package:task_manager/ui/state_managers/otp_verification_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class OtpVerificationScreen extends StatelessWidget {
  String email;

  OtpVerificationScreen(this.email, {Key? key}) : super(key: key);
  String? verifidPinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  'PIN Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'A 6 digits pin will sent to your email address',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.red,
                    activeColor: Colors.white,
                    selectedColor: Colors.green,
                    selectedFillColor: Colors.white,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  cursorColor: Colors.green,
                  enablePinAutofill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {
                    verifidPinCode = value;
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<OTPVerifyController>(
                  builder: (otpController) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          otpController
                              .verifingOTP(email, verifidPinCode!)
                              .then((value) {
                            if (value == true) {
                              Get.to(
                                  ResetPasswordScreen(email, verifidPinCode!));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('OTP Verification Failed')));
                            }
                          });
                        },
                        child: const Text('Verify'),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offAll(LoginScreen());
                        },
                        child: const Text('Sign in')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
