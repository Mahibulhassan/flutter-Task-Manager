import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class DeleteTaskController extends GetxController {
  Future<bool> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
       return true;
    } else {
      return false;
    }
  }
}