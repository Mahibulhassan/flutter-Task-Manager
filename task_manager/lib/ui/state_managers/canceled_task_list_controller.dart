import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class CanceledTaskListController extends GetxController {
  bool _getCanceledTasksProgress = false;
  TaskListModel _taskListModel = TaskListModel();
  bool get isProgress => _getCanceledTasksProgress;
  TaskListModel get deletetaskList=> _taskListModel;
  Future<void> getCanceledTasks() async {
    _getCanceledTasksProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.canceledTaskListn);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
        Get.snackbar("Error", 'In progress tasks get failed');
    }
    _getCanceledTasksProgress = false;
    update();
  }
}