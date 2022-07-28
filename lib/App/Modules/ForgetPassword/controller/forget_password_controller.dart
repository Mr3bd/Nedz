import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
