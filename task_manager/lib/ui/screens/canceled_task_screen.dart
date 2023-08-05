import 'package:flutter/material.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/update_task_status_bottom_sheet.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_list_titel.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

import '../../data/services/network_caller.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCanceledTasksProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getCanceledTasks() async {
    _getCanceledTasksProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.canceledTaskListn);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('In progress tasks get failed')));
      }
    }
    _getCanceledTasksProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCanceledTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileBanner(),
            Expanded(
              child: _getCanceledTasksProgress
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.separated(
                itemCount: _taskListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskListTile(
                    color: Colors.red,
                    data: _taskListModel.data![index],
                    onDeleteTap: (){
                      deleteTask(_taskListModel.data![index].sId!);
                    },
                    onEditTap: (){
                      showStatusUpdateBottomSheet(_taskListModel.data![index]);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getCanceledTasks();
        });
      },
    );
  }
}