import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/update_task_status_bottom_sheet.dart';
import 'package:task_manager/ui/state_managers/task_completed_controller.dart';
import 'package:task_manager/ui/state_managers/task_delete_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_list_titel.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final _completeTaskController = Get.find<CompletedTaskListController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _completeTaskController.getCompletedTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileBanner(),
            GetBuilder<CompletedTaskListController>(
              builder: (completedController){
                return Expanded(
                  child: completedController.isProgress
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.separated(
                    itemCount: completedController.completedTaskList.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GetBuilder<DeleteTaskController>(
                        builder: (deleteTaskController){
                           return TaskListTile(
                            color: Colors.green,
                            data: completedController.completedTaskList.data![index],
                            onDeleteTap: (){
                              deleteTaskController.deleteTask(completedController.completedTaskList.data![index].sId!).then((value){
                                if(value == true){
                                  Get.snackbar("Success", 'Deletion of task has been Complete');
                                  _completeTaskController.getCompletedTasks();
                                }else{
                                  Get.snackbar("Error", 'Deletion of task has been failed');
                                }
                              });
                            },
                            onEditTap: (){
                              showStatusUpdateBottomSheet(completedController.completedTaskList.data![index]);
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
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          _completeTaskController.getCompletedTasks();
        });
      },
    );
  }
}