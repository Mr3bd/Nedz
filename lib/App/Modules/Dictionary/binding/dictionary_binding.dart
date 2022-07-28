import 'package:get/get.dart';
import 'package:neds/App/Modules/Dictionary/controller/dictionary_controller.dart';

class DictionarydBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DictionaryController>(
      () => DictionaryController(),
    );
  }
}
