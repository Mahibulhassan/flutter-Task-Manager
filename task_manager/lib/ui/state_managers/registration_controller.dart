import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class RegistrationController extends GetxController {
  bool _signUpInProgress = false;

  bool get signInProgress => _signUpInProgress;

  Future<bool> userSignUp(String email, String firstName, String lastName,
      String mobile, String passsword, String photo) async {
    _signUpInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": passsword,
      "photo": photo
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
