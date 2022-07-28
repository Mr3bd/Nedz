import 'package:get/get.dart';
import 'package:neds/App/Modules/SelectedCategoryBySearch/controller/selected_category_by_search_controller.dart';

class SelectedCategoryBySearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedCategoryBySearchController>(
      () => SelectedCategoryBySearchController(),
    );
  }
}
