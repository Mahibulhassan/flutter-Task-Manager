import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/update_task_status_bottom_sheet.dart';
import 'package:task_manager/ui/state_managers/canceled_task_list_controller.dart';
import 'package:task_manager/ui/state_managers/task_delete_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_list_titel.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final _canceledTaskListController = Get.find<CanceledTaskListController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _canceledTaskListController.getCanceledTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileBanner(),
            GetBuilder<CanceledTaskListController>(
              builder: (canceledTaskController) {
                return Expanded(
                  child: canceledTaskController.isProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: _canceledTaskListController
                                  .deletetaskList.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return GetBuilder<DeleteTaskController>(
                              builder: (deleteTaskController){
                                return TaskListTile(
                                  color: Colors.red,
                                  data: _canceledTaskListController
                                      .deletetaskList.data![index],
                                  onDeleteTap: () {
                                    deleteTaskController.deleteTask(_canceledTaskListController
                                        .deletetaskList.data![index].sId!).then((value) {
                                          if(value == true){
                                            Get.snackbar("Success", 'Deletion of task has been Success');
                                            _canceledTaskListController.getCanceledTasks();
                                          }else{
                                            Get.snackbar("Error", 'Deletion of task has been failed');
                                          }
                                    });
                                  },
                                  onEditTap: () {
                                    showStatusUpdateBottomSheet(
                                        _canceledTaskListController
                                            .deletetaskList.data![index]);
                                  },
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 4,
                            );
                          },
                        ),
                );
              },
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
        return UpdateTaskStatusSheet(
            task: task,
            onUpdate: () {
              _canceledTaskListController.getCanceledTasks();
            });
      },
    );
  }
}
