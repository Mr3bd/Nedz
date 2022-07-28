import 'package:get/get.dart';
import 'package:neds/App/Modules/AddCategoryFromLocal/controller/add_category_from_local_controller.dart';

class AddCategoryFromLocalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryFromLocalController>(
      () => AddCategoryFromLocalController(),
    );
  }
}
