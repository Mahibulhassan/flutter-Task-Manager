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
  static String deleteTask= '$_baseUrl/deleteTask/';
  static String countTaskStatus= '$_baseUrl/taskStatusCount';
}