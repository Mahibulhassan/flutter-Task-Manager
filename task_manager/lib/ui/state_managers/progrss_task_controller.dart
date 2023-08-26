import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class InProgressTaskController extends GetxController {
  bool _getProgressTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get isProgress => _getProgressTasksInProgress;

  TaskListModel get progressTaskList => _taskListModel;

  Future<void> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.inProgressTaskListn);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
       Get.snackbar("Error", 'In progress tasks get failed');
    }
    _getProgressTasksInProgress = false;
    update();
  }
}