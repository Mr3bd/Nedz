import 'package:get/get.dart';
import 'package:neds/App/Modules/AddCategory/controller/add_category_controller.dart';

class AddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryController>(
      () => AddCategoryController(),
    );
  }
}
