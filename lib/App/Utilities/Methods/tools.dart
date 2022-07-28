import 'dart:io';
import 'dart:math';
import 'package:neds/App/Services/translation_service.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Utilities/Constants/UI.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonTools {
  String? passwordValidate(String? value, TextEditingController controller) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    regExp.hasMatch(controller.text);
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 8) {
      return value = 'invalid password'.tr;
    } else if (regExp.hasMatch(controller.text) == false) {
      return value = 'please enter valid password'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? emailValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (!controller.text.contains('@')) {
      return value = 'please enter vaild email'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? nameValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    } else if (controller.text.length < 6) {
      return value = 'please enter vaild name'.tr;
    } else {
      value = null;
    }
    return value;
  }

  String? phoneNumberValidate(String? value, TextEditingController controller) {
    if (controller.text.isEmpty) {
      return value = 'this field is required'.tr;
    }
    if (value!.contains(RegExp('[a-zA-Zا-ي?=.*!@#\$%^&*(),.?:{}|<>]'))) {
      return value = 'should be contains numbers only'.tr;
    } else if (controller.text.startsWith('0') == false) {
      value = 'phone number must start with 0'.tr;
    } else {
      if (controller.text.length != 10)
        value = 'phone number must be 10 numbers'.tr;
      else
        value = null;
    }
    return value;
  }

  String? otpValidation(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (controller.text.length > 6) {
      return 'this filed should be 6 digits';
    }
    return null;
  }

  String? requiredFieldValidate(TextEditingController controller) {
    if (controller.value.text.isEmpty || controller.value.text == '') {
      return 'this field is required'.tr;
    }
    return null;
  }

  String? validatePinputOtp(TextEditingController controller) {
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    regExp.hasMatch(controller.text);
    if (controller.text.isEmpty) {
      return 'this field is required'.tr;
    } else if (regExp.hasMatch(controller.text) == false) {
      return 'inValidOtp'.tr;
    }
    return null;
  }

  void showSuccessSnackBar(String message, {int duration = 3}) {
    Get.showSnackbar(UI.SuccessSnackBar(
        title: 'success', message: message.tr, duration: duration));
  }

  void showFailedSnackBar(String message) {
    Get.showSnackbar(UI.ErrorSnackBar(
      title: 'failed',
      message: message.tr,
    ));
  }

  void showLoading() {
    Get.dialog(
      Center(
        child: Container(
          width: Get.width * 0.25,
          height: Get.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.black.withOpacity(0.5),
          ),
          child: Center(
              child: Theme(
                  data: ThemeData(
                      cupertinoOverrideTheme: const CupertinoThemeData(
                          brightness: Brightness.dark)),
                  child: const CupertinoActivityIndicator(
                    radius: 15.0,
                  ))),
        ),
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
  }

  void showLoadingCustom(double backgroundOpacity, Widget widget) {
    Get.dialog(
        Center(
          child: widget,
        ),
        barrierDismissible: true,
        barrierColor: AppColors.white.withOpacity(backgroundOpacity));
  }

  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  int createRandom() {
    int randomID;
    Random random = new Random();
    int randomFirst = random.nextInt(1000000000) + 1000000;
    int randomSecond = random.nextInt(100000) + randomFirst;
    randomID = randomFirst + randomSecond;
    return randomID;
  }

  void ShowWarningDialogMutliButtons(
      BuildContext context,
      String title,
      String message,
      String fbTitle,
      String sbTitle,
      Color fbColor,
      Color sbColor,
      VoidCallback fbFunction,
      VoidCallback sbFunction) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: Get.textTheme.headline3!.copyWith(color: AppColors.black),
          ),
        ),
        content: Text(
          message,
          style: Get.textTheme.headline6!.copyWith(color: AppColors.black),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: Text(
              fbTitle,
              style: Get.textTheme.headline6!
                  .copyWith(color: fbColor, fontWeight: FontWeight.w500),
            ),
            onPressed: fbFunction,
          ),
          CupertinoDialogAction(
            child: Text(
              sbTitle,
              style: Get.textTheme.headline6!
                  .copyWith(color: sbColor, fontWeight: FontWeight.w500),
            ),
            onPressed: sbFunction,
          )
        ],
      ),
    );
  }

  void ShowWarningDialogSingleButton(
      BuildContext context,
      String title,
      String message,
      String buttonTitle,
      Color buttonTitleColor,
      VoidCallback buttonFunction) {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: Get.textTheme.headline3!.copyWith(color: AppColors.black),
          ),
        ),
        content: Container(
          child: Text(
            message,
            style: Get.textTheme.bodyText2!.copyWith(color: AppColors.black),
            maxLines: 3,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: Text(
              buttonTitle,
              style: Get.textTheme.headline6!.copyWith(
                  color: buttonTitleColor, fontWeight: FontWeight.w500),
            ),
            onPressed: buttonFunction,
          ),
        ],
      ),
    );
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  String getVerboseDateTimeRep(String date) {
    var dateUTC = DateTime.parse(date.replaceAll('/', '-') + 'Z').toUtc();

    var dateTime = dateUTC.toLocal();

    DateTime now = DateTime.now().toUtc();
    bool isArabic = TranslationService().isLocaleArabic();

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes < 2) {
      return isArabic ? 'الان' : 'Just Now';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inMinutes >= 2 &&
        now.difference(dateTime).inMinutes < 60) {
      int diff = now.difference(dateTime).inMinutes;

      return TranslationService().isLocaleArabic()
          ? 'قبل $diff دقيقة'
          : '$diff minutes ago';
    }

    if (now.day == dateTime.day &&
        now.month == dateTime.month &&
        now.year == dateTime.year &&
        now.difference(dateTime).inHours >= 1 &&
        now.difference(dateTime).inHours < 2) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعة' : '$diff hour ago';
    }

    if (now.difference(dateTime).inHours >= 2 &&
        now.difference(dateTime).inHours < 3) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل ساعتين' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours >= 3 &&
        now.difference(dateTime).inHours <= 10) {
      int diff = now.difference(dateTime).inHours;

      return isArabic ? 'قبل $diff ساعات' : '$diff hours ago';
    }

    if (now.difference(dateTime).inHours > 10 &&
        now.difference(dateTime).inHours <= 24) {
      return isArabic ? 'اليوم' : 'Today';
    }

    if (now.difference(dateTime).inHours > 24 &&
        now.difference(dateTime).inHours <= 48) {
      return isArabic ? 'أمس' : 'Yesterday';
    }

    if (now.difference(dateTime).inDays >= 2 &&
        now.difference(dateTime).inDays <= 6) {
      int diff = now.difference(dateTime).inDays;

      return isArabic ? 'قبل $diff أيام' : '$diff days ago';
    }

    if (now.difference(dateTime).inDays >= 7 &&
        now.difference(dateTime).inDays < 30) {
      int diff = now.difference(dateTime).inDays ~/ 7;

      return isArabic ? 'قبل $diff أسبوع' : '$diff weeks ago';
    }

    if (now.difference(dateTime).inDays > 29 &&
        (now.difference(dateTime).inDays ~/ 30).toInt() < 12) {
      double diff = now.difference(dateTime).inDays / 30;

      int months = diff.toInt();

      return isArabic ? '$months شهر' : '$months month';
    }

    if ((now.difference(dateTime).inDays ~/ 30).toInt() >= 12) {
      double diff = now.difference(dateTime).inDays / 365;

      int years = diff.toInt();

      return isArabic ? '$years س' : '$years y';
    } else {
      return intl.DateFormat.yMMMMd().format(dateTime) +
          ' - ' +
          intl.DateFormat.jm().format(dateTime);
    }
  }

  void openURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  int getRandomSmallNumberFromList() {
    var list = [1, 2, 3, 4, 5, 7];
    return getRandomElement(list);
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  void showWarningSnackBar(String title) {
    Get.showSnackbar(UI.WarningSnackBar(
      title: title,
      message: '',
    ));
  }
}
