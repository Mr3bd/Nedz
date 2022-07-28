import 'package:get/get.dart';
import 'package:neds/App/Modules/ABFeelings/controller/ab_feelings_controller.dart';

class ABFeelingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ABFeelingsController>(
      () => ABFeelingsController(),
    );
  }
}
