import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/auth/signup_screen.dart';
import 'package:task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager/ui/state_managers/login_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();

  final TextEditingController _passwordTEController = TextEditingController();

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
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter valid Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<LoginController>(
                  builder: (logInController) {
                    return SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: logInController.logInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              logInController.login(_emailTEController.text.trim(),_passwordTEController.text).then((value){
                                if(value == true){
                                  Get.offAll(const BottomNavBaseScreen());
                                }else{
                                  Get.snackbar("Failed", "Login Failed ! Try again",snackPosition: SnackPosition.BOTTOM);
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward_ios)),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(EmailVerificationScreen());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(SignUpScreen());
                        },
                        child: const Text('Sign up')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
