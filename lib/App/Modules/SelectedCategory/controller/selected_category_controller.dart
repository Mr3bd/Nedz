import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Modules/Category/controller/category_controller.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SelectedCategoryController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  final CategoryController categoryController = Get.find();
  Rx<AutisticPatient> currentChild = AutisticPatient().obs;
  List<CategoryItem> categories = [];
  SpeechToText? speechToText;
  RxBool isListening = false.obs;
  RxString text = ''.obs;
  RxDouble confidence = (1.0).obs;
  RxInt index = (-1).obs;

  var arguments = Get.arguments;

  @override
  Future<void> onInit() async {
    speechToText = SpeechToText();
    var data = authManager.storage.read('localSelectedCategories');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    categories.addAll(temp.isEmpty
        ? []
        : temp
            .map<CategoryItem>((jsonItem) {
              return CategoryItem.fromJson(jsonItem);
            })
            .toList()
            .toList());
    index.value = categories.indexWhere((cat) =>
        (cat.apId == authManager.currentChildId.value) &&
        (cat.type == arguments[0]) &&
        (cat.realName == categoryController.categories[arguments[1]].realName));

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    currentChild.value = authManager.getCurrentChild();

    super.onReady();
  }

  // void initSpeech() async {
  //   speechEnabled = await speechToText.initialize();
  // }

  // void startListening(BuildContext context) async {
  //   if (categories[index.value].nickName != null) {
  //     authManager.commonTools.ShowWarningDialogMutliButtons(
  //         context,
  //         'Warning',
  //         'There is a previous word for this item Do you want to change it?',
  //         'Sure',
  //         'Cancel',
  //         AppColors.blue,
  //         AppColors.failed, () async {
  //       Get.back();
  //       await speechToText
  //           .listen(
  //               onResult: onSpeechResult,
  //               listenFor: Duration(seconds: 3),
  //               pauseFor: Duration(seconds: 3),
  //               cancelOnError: true)
  //           .then((value) => print(value));
  //     }, () {
  //       Get.back();
  //       return;
  //     });
  //   } else {
  //     print('--   fdfdf --- ');
  //     await speechToText
  //         .listen(
  //           onResult: onSpeechResult,
  //           listenFor: Duration(seconds: 3),
  //           pauseFor: Duration(seconds: 3),
  //           cancelOnError: true,
  //         )
  //         .then((value) => print(value));
  //   }
  // }

  // void stopListening() async {
  //   print(22);

  //   await speechToText.stop();
  // }

  // void onSpeechResult(SpeechRecognitionResult result) {
  //   print('object');
  //   lastWords = result.recognizedWords;
  //   changeNickName(lastWords);
  //   log(lastWords);
  // }

  String getPageTitle() {
    switch (arguments[0]) {
      case 1:
        return 'Fruits';

      case 2:
        return 'Drinks';

      case 3:
        return 'Food';

      case 4:
        return 'Sweets';

      case 5:
        return 'Toys';

      default:
        return '';
    }
  }

  changeNickName() async {
    if (index.value >= 0) {
      categories[index.value].nickName = text.value;
      await authManager.storage
          .write('localSelectedCategories', jsonEncode(categories));

      authManager.commonTools
          .showSuccessSnackBar('The voice word of this item has been changed');
    }
  }

  void listen(BuildContext context) async {
    if (!isListening.value) {
      bool available = await speechToText!.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => authManager.commonTools.showWarningSnackBar(
              'Sorry, we can\'t detect the word, please try again!'));
      if (available) {
        if (categories[index.value].nickName != null) {
          authManager.commonTools.ShowWarningDialogMutliButtons(
              context,
              'Warning',
              'There is a previous word for this item Do you want to change it?',
              'Sure',
              'Cancel',
              AppColors.blue,
              AppColors.failed, () async {
            Get.back();
            text.value = '';
            isListening.value = true;
            speechToText!
                .listen(
                    onResult: (val) {
                      print(val.toJson());
                      text.value = val.recognizedWords;

                      if (val.hasConfidenceRating && val.confidence > 0) {
                        confidence.value = val.confidence;
                      }
                    },
                    cancelOnError: true,
                    listenFor: Duration(seconds: 3))
                .whenComplete(
                    () => Future.delayed(Duration(milliseconds: 3500), () {
                          if (text.value.isNotEmpty) {
                            authManager.commonTools.ShowWarningDialogMutliButtons(
                                context,
                                'Result',
                                'The result it\'s "${text.value}", do you want set it?',
                                'Yes',
                                'No',
                                AppColors.blue,
                                AppColors.failed, () async {
                              Get.back();
                              await changeNickName();
                            }, () {
                              Get.back();
                            });
                          } else {
                            authManager.commonTools.showWarningSnackBar(
                                'Sorry, we can\'t detect the word, please try again!');
                          }
                        }));
          }, () {
            Get.back();
            return;
          });
        } else {
          text.value = '';

          isListening.value = true;
          speechToText!
              .listen(
                  onResult: (val) {
                    print(val.toJson());
                    text.value = val.recognizedWords;

                    if (val.hasConfidenceRating && val.confidence > 0) {
                      confidence.value = val.confidence;
                    }
                  },
                  cancelOnError: true,
                  listenFor: Duration(seconds: 3))
              .whenComplete(
                  () => Future.delayed(Duration(milliseconds: 3500), () {
                        if (text.value.isNotEmpty) {
                          authManager.commonTools.ShowWarningDialogMutliButtons(
                              context,
                              'Result',
                              'The result it\'s "${text.value}", do you want set it?',
                              'Yes',
                              'No',
                              AppColors.blue,
                              AppColors.failed, () async {
                            Get.back();
                            await changeNickName();
                          }, () {
                            Get.back();
                          });
                        } else {
                          authManager.commonTools.showWarningSnackBar(
                              'Sorry, we can\'t detect the word, please try again!');
                        }
                      }));
        }
      }
    } else {
      isListening.value = false;
      speechToText!.stop();
    }
  }
}
