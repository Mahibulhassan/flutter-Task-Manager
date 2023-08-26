import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class CompletedTaskListController extends GetxController {
  bool _getCompletedTasksProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get isProgress => _getCompletedTasksProgress;
  TaskListModel get completedTaskList => _taskListModel;

  Future<void> getCompletedTasks() async {
    _getCompletedTasksProgress = true;
   update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTaskListn);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
     Get.snackbar("Error", 'In progress tasks get failed');
    }
    _getCompletedTasksProgress = false;
   update();
  }
}