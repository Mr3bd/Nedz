import 'package:neds/App/Modules/ABSurvey/controller/ab_survey_controller.dart';
import 'package:get/get.dart';

class ABSurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ABSurveyController>(
      () => ABSurveyController(),
    );
  }
}
