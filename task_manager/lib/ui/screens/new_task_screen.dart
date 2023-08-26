import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_list_model.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/update_task_status_bottom_sheet.dart';
import 'package:task_manager/ui/state_managers/new_task_controller.dart';
import 'package:task_manager/ui/state_managers/summery_count_controller.dart';
import 'package:task_manager/ui/state_managers/task_delete_controller.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/summary_card.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/task_list_titel.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _newTaskListController = Get.find<NewTaskController>();
  final _summaryController = Get.find<SummaryCountController>();
  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryController.getCountSummary();
      _newTaskListController.getNewTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileBanner(),
            GetBuilder<SummaryCountController>(
              builder: (summaryCountController){
                return summaryCountController.isProgressLoading ?const LinearProgressIndicator():Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _summaryController.summaryCount.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return SummaryCard(
                          title: _summaryController.summaryCount.data![index].sId ?? 'New',
                          number: _summaryController.summaryCount.data![index].sum ?? 0,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 4,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            GetBuilder<NewTaskController>(
              builder: (newTaskController){
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _newTaskListController.getNewTasks();
                      _summaryController.getCountSummary();
                    },
                    child: newTaskController.isTaskInProgress
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.separated(
                      itemCount: newTaskController.newTaskList.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return  GetBuilder<DeleteTaskController>(
                          builder: (deleteTaskController){
                            return TaskListTile(
                              color: Colors.blue,
                              data: newTaskController.newTaskList.data![index],
                              onDeleteTap: () {
                                deleteTaskController.deleteTask(newTaskController.newTaskList.data![index].sId!).then((value) {
                                  if(value == true){
                                    Get.snackbar("Success", 'Deletion of task has been Success');
                                    _newTaskListController.getNewTasks();
                                    _summaryController.getCountSummary();
                                  }else{
                                    Get.snackbar("Error", 'Deletion of task has been failed');
                                  }
                                });
                              },
                              onEditTap: () {
                                showStatusUpdateBottomSheet(
                                    newTaskController.newTaskList.data![index]);
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(AddNewTaskScreen());
        },
      ),
    );
  }


  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          _newTaskListController.getNewTasks();
          _summaryController.getCountSummary();
        });
      },
    );
  }
}