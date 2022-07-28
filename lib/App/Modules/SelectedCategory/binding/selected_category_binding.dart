import 'package:neds/App/Modules/Category/controller/category_controller.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/SelectedCategory/controller/selected_category_controller.dart';

class SelectedCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedCategoryController>(
      () => SelectedCategoryController(),
    );
  }
}
