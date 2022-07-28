import 'package:neds/App/Modules/Splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return controller.waitingView();
  }
}
