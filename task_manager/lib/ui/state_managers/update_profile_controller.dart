import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  bool _profileInProgress = false;

  bool get isProgress => _profileInProgress;

  Future<bool> updateProfile(String fName, String lName,String phone,String photo,String password) async {
    _profileInProgress = true;
    update();
    final Map<String, dynamic> requestBody = {
      "firstName": fName,
      "lastName": lName,
      "mobile": phone,
      "photo": photo,
      "password":password
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _profileInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

}