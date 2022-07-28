import 'package:get/get.dart';
import 'package:neds/App/Modules/CategoryBySearch/controller/category_by_search_controller.dart';

class CategoryBySearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryBySearchController>(
      () => CategoryBySearchController(),
    );
  }
}
