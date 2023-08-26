import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class EmailVerificationController extends GetxController{
  Future<bool> verifyEmailAddress(String email) async{
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.verifyEmail(email));
    if(response.isSuccess){
      return true;
    }else {
      return false;
    }
  }
}