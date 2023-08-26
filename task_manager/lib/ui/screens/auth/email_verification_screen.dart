import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/auth/otp_verification_screen.dart';
import 'package:task_manager/ui/state_managers/email_varification_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

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
                const SizedBox(height: 64,),
                Text(
                  'Your email address',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(height: 4,),
                Text(
                  'A 6 digits pin will sent to your email address',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<EmailVerificationController>(
                  builder: (emailVarifiactionController) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emailController.text
                              .trim()
                              .isNotEmpty) {
                            emailVarifiactionController.verifyEmailAddress(_emailController.text.trim()).then((value){
                              if(value == true){
                                Get.to(OtpVerificationScreen(_emailController.text.trim()));
                              }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Email Verification Failed')));
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Input Valid Email Address")));
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined),
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
                    TextButton(onPressed: () {
                      Get.back();
                    }, child: const Text('Sign in')),
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