import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model/auth_utility.dart';
import 'package:task_manager/data/model/login_model.dart';
import 'package:task_manager/ui/state_managers/update_profile_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _updateProfileController = Get.find<UpdateProfileController>();
  UserData userData = AuthUtility.userInfo.data!;
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _emailTEController.text = userData.email ?? '';
    _firstNameTEController.text = userData.firstName ?? '';
    _lastNameTEController.text = userData.lastName ?? '';
    _mobileTEController.text = userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileBanner(
                  isUpdateScreen: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Update Profile',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                color: Colors.grey,
                                child: const Text(
                                  'Photos',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Visibility(
                                  visible: imageFile != null,
                                  child: Text(imageFile?.name ?? ''))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
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
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 11) {
                            return 'Enter your valid mobile no';
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
                          if ((value?.isEmpty ?? true) || value!.length <= 5) {
                            return 'Enter a password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<UpdateProfileController>(
                        builder: (profileController){
                          return SizedBox(
                            width: double.infinity,
                            child: _updateProfileController.isProgress
                                ? const Center(
                              child: CircularProgressIndicator(),
                            )
                                : ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _updateProfileController.updateProfile(
                                    _firstNameTEController.text.trim(),
                                    _lastNameTEController.text.trim(),
                                    _mobileTEController.text.trim(),
                                    "",_passwordTEController.text).then((value) {
                                  if(value == true){
                                    Get.snackbar("Success", 'Profile updated!');
                                    userData.firstName = _firstNameTEController.text.trim();
                                    userData.lastName = _lastNameTEController.text.trim();
                                    userData.mobile = _mobileTEController.text.trim();
                                    AuthUtility.updateUserInfo(userData);
                                    _passwordTEController.clear();
                                  }else{
                                    Get.snackbar("Error", 'Profile update failed! Try again.');
                                  }
                                });
                              },
                              child: const Text('Update'),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectImage() {
    picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = xFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }
}
