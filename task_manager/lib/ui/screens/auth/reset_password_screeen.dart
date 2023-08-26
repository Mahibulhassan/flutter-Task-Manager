import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/state_managers/reset_password_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatelessWidget {
  String email;
  String otp;

  ResetPasswordScreen(this.email, this.otp, {Key? key}) : super(key: key);

  final TextEditingController _passwordTEController = TextEditingController();

  final TextEditingController _rePasswordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Minimum password should be 8 letters with numbers & symbols',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length <= 7) {
                        return 'Enter a password more than 8 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _rePasswordTEController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length <= 7) {
                        return 'Enter a password more than 8 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<ResetPasswordController>(
                    builder: (resetPasswordController) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            resetPasswordController
                                .postChangePassword(email, otp,
                                    _passwordTEController.text)
                                .then((value) {
                              if (value == true) {
                                Get.snackbar("Success", 'Password Changed',
                                    snackPosition: SnackPosition.BOTTOM);
                                Get.offAll(LoginScreen());
                              } else {
                                Get.snackbar("Failed", 'Try again later !',
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            });
                          },
                          child: const Text('Confirm'),
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
      ),
    );
  }
}
