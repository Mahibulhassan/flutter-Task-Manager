import 'package:get/get.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/summary_count_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class SummaryCountController extends GetxController {
  bool _getCountSummaryInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();

  bool get isProgressLoading => _getCountSummaryInProgress;
  SummaryCountModel get summaryCount => _summaryCountModel;

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.countTaskStatus);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      Get.snackbar("Error", 'get new task data failed');
    }
    _getCountSummaryInProgress = false;
   update();
  }
}