import 'dart:convert';

import 'package:get/get.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';

class DictionaryController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  Rx<AutisticPatient> curentChild = AutisticPatient().obs;
  RxList<CategoryItem> categories = <CategoryItem>[].obs;

  @override
  Future<void> onInit() async {
    curentChild.value = authManager.getCurrentChild();
    var data = authManager.storage.read('localSelectedCategories');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    categories.addAll(temp.isEmpty
        ? []
        : temp
            .map<CategoryItem>((jsonItem) {
              return CategoryItem.fromJson(jsonItem);
            })
            .toList()
            .where((cat) =>
                (cat.apId == authManager.currentChildId.value) &&
                (cat.nickName != null))
            .toList());

    print(categories.length);

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}
