import 'dart:async';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Modules/CategoryBySearch/controller/category_by_search_controller.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:get/get.dart';

class SelectedCategoryBySearchController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final CategoryBySearchController categoryBySearchController = Get.find();
  Rx<AutisticPatient> currentChild = AutisticPatient().obs;

  var arguments = Get.arguments;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    currentChild.value = authManager.getCurrentChild();

    super.onReady();
  }
}
