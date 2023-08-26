import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/utils/urls.dart';

import '../../data/services/network_caller.dart';

class NewTaskController extends GetxController {
  bool _getNewTaskInProgress = false;
  bool get isTaskInProgress => _getNewTaskInProgress;
  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get newTaskList => _taskListModel;
  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.newTaskListn);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar("Error", 'Summary data get failed');
    }
    _getNewTaskInProgress = false;
    update();
  }
}