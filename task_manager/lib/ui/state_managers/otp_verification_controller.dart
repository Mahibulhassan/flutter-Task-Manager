import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class OTPVerifyController extends GetxController {
  Future<bool> verifingOTP(String email,String otp) async{
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.verifyOTP(email,otp));
    if(response.isSuccess){
      return true;
    }else {
      return false;
    }
  }
}