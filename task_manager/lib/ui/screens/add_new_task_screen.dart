import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/state_managers/add_new_task_controller.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class AddNewTaskScreen extends StatelessWidget {
  AddNewTaskScreen({Key? key}) : super(key: key);

  final TextEditingController _titleTEController = TextEditingController();

  final TextEditingController _descriptionTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileBanner(),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Add new task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(hintText: 'Title'),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Require Titel";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Require Description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder<AddNewTaskController>(
                      builder: (newTaskController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible:
                                newTaskController.newTaskInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  newTaskController
                                      .addNewTask(
                                          _titleTEController.text.trim(),
                                          _descriptionTEController.text.trim())
                                      .then((value) {
                                    if (value == true) {
                                      _titleTEController.clear();
                                      _descriptionTEController.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Task added successfully')));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Task add failed!')));
                                    }
                                  });
                                },
                                child: const Icon(Icons.arrow_forward_ios)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
