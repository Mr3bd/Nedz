import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UI {
  static GetSnackBar SuccessSnackBar(
      {String title = 'success', String? message, int duration = 3}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline4!.merge(
              TextStyle(color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: Text(message!,
          style: Get.textTheme.headline6!.merge(
              TextStyle(color: AppColors.white, fontWeight: FontWeight.w500))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.primaryColor,
      icon: Icon(Icons.check_circle_outline, size: 32, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
      barBlur: 20.0,
      overlayBlur: 1.0,
    );
  }

  static BoxShadow boxShadow = BoxShadow(
    blurRadius: 4,
    color: AppColors.grey.withOpacity(0.1),
    offset: const Offset(0, 0),
    spreadRadius: 3,
  );

  static GetSnackBar WarningSnackBar(
      {String? title, String message = '', int duration = 5}) {
    return GetSnackBar(
      titleText: Text(title!.tr,
          style: Get.textTheme.headline5!.merge(
              TextStyle(color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: const SizedBox(),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(24.0),
      backgroundColor: AppColors.yellow,
      icon:
          Icon(Icons.remove_circle_outline, size: 24.0, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      borderRadius: 10.0,
      duration: Duration(seconds: duration),
      barBlur: 20.0,
      overlayBlur: 1.0,
    );
  }

  static GetSnackBar ErrorSnackBar(
      {String title = 'failed', String? message, int duration = 5}) {
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline4!.merge(
              TextStyle(color: AppColors.white, fontWeight: FontWeight.w500))),
      messageText: Text(message!,
          style: Get.textTheme.headline6!.merge(
              TextStyle(color: AppColors.white, fontWeight: FontWeight.w500))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: duration),
      barBlur: 20.0,
      overlayBlur: 1.0,
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll('#', '0xFF')))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static InputDecoration getInputDecoration(
      {String hintText = '', IconData? iconData, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      errorMaxLines: 3,
      errorStyle: Get.theme.textTheme.bodyText2!
          .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
      hintStyle: Get.theme.textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w500, color: AppColors.black.withOpacity(0.8)),
      prefixIcon: iconData != null
          ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
          : const SizedBox(),
      prefixIconConstraints: iconData != null
          ? const BoxConstraints.expand(width: 38, height: 38)
          : const BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
    );
  }
}
