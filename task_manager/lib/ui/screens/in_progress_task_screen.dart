import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/update_task_status_bottom_sheet.dart';
import 'package:task_manager/ui/state_managers/progrss_task_controller.dart';
import 'package:task_manager/ui/state_managers/task_delete_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_list_titel.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final _inProgressTaskController = Get.find<InProgressTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _inProgressTaskController.getInProgressTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileBanner(),
            GetBuilder<InProgressTaskController>(
              builder: (progressController){
                return Expanded(
                  child: progressController.isProgress
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.separated(
                    itemCount: progressController.progressTaskList.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GetBuilder<DeleteTaskController>(
                        builder: (deleteTaskController){
                          return TaskListTile(
                            color: Colors.purple,
                            data: progressController.progressTaskList.data![index],
                            onDeleteTap: (){
                              deleteTaskController.deleteTask(progressController.progressTaskList.data![index].sId!).then((value){
                                if(value == true){
                                  Get.snackbar("Success", 'Deletion of task has been Complete');
                                  _inProgressTaskController.getInProgressTasks();
                                }else{
                                  Get.snackbar("Error", 'Deletion of task has been failed');
                                }
                              });
                            },
                            onEditTap: (){
                              showStatusUpdateBottomSheet(progressController.progressTaskList.data![index]);
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
          _inProgressTaskController.getInProgressTasks();
        });
      },
    );
  }
}