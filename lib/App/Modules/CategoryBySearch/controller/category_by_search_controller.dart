import 'dart:async';
import 'dart:convert';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:get/get.dart';

class CategoryBySearchController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  RxList<CategoryItem> categories = <CategoryItem>[].obs;
  Rx<AutisticPatient> currentChild = AutisticPatient().obs;
  var arguments = Get.arguments;

  @override
  Future<void> onInit() async {
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
                (cat.nickName != null) &&
                (cat.nickName.toString().toLowerCase() ==
                    arguments[0].toLowerCase()))
            .toList());

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    currentChild.value = authManager.getCurrentChild();
    super.onReady();
  }
}
