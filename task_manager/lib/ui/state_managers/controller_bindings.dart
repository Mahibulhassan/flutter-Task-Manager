import 'package:get/get.dart';
import 'package:task_manager/ui/state_managers/add_new_task_controller.dart';
import 'package:task_manager/ui/state_managers/canceled_task_list_controller.dart';
import 'package:task_manager/ui/state_managers/email_varification_controller.dart';
import 'package:task_manager/ui/state_managers/login_controller.dart';
import 'package:task_manager/ui/state_managers/new_task_controller.dart';
import 'package:task_manager/ui/state_managers/otp_verification_controller.dart';
import 'package:task_manager/ui/state_managers/progrss_task_controller.dart';
import 'package:task_manager/ui/state_managers/registration_controller.dart';
import 'package:task_manager/ui/state_managers/reset_password_controller.dart';
import 'package:task_manager/ui/state_managers/summery_count_controller.dart';
import 'package:task_manager/ui/state_managers/task_completed_controller.dart';
import 'package:task_manager/ui/state_managers/task_delete_controller.dart';
import 'package:task_manager/ui/state_managers/update_profile_controller.dart';


class ControllerBuinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<RegistrationController>(RegistrationController());
    Get.put<ResetPasswordController>(ResetPasswordController());
    Get.put<EmailVerificationController>(EmailVerificationController());
    Get.put<OTPVerifyController>(OTPVerifyController());
    Get.put<AddNewTaskController>(AddNewTaskController());
    Get.put<CanceledTaskListController>(CanceledTaskListController());
    Get.put<DeleteTaskController>(DeleteTaskController());
    Get.put<CompletedTaskListController>(CompletedTaskListController());
    Get.put<InProgressTaskController>(InProgressTaskController());
    Get.put<NewTaskController>(NewTaskController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<UpdateProfileController>(UpdateProfileController());
  }
}