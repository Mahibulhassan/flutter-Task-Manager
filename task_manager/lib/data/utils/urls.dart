class Urls {
  Urls._();

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String newTaskListn= '$_baseUrl/listTaskByStatus/New';
  static String inProgressTaskListn= '$_baseUrl/listTaskByStatus/Progress';
  static String canceledTaskListn= '$_baseUrl/listTaskByStatus/Canceled';
  static String completedTaskListn= '$_baseUrl/listTaskByStatus/Completed';
  static String countTaskStatus= '$_baseUrl/taskStatusCount';
  static String recoverResetPassword= '$_baseUrl/RecoverResetPass';
  static String updateProfile= '$_baseUrl/profileUpdate';

  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String verifyEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';

  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';

  static String verifyOTP(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$otp';
}