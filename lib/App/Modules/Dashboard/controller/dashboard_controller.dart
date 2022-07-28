import 'dart:async';
import 'dart:convert';
import 'package:neds/App/Models/Main/AssetItem.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Modules/CategoryBySearch/binding/category_by_search_binding.dart';
import 'package:neds/App/Modules/CategoryBySearch/view/category_by_search_view.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DashboardController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  SpeechToText? speechToText;
  RxBool isListening = false.obs;
  RxString text = ''.obs;
  RxDouble confidence = (1.0).obs;
  RxList<AssetItem> mainCategories = [
    AssetItem(path: 'assets/svg/fruits-9605.svg', name: '1'),
    AssetItem(path: 'assets/svg/glass-of-water.svg', name: '2'),
    AssetItem(path: 'assets/svg/cupcake.svg', name: '4'),
    AssetItem(path: 'assets/svg/spaghetti.svg', name: '3'),
    AssetItem(path: 'assets/svg/toys.svg', name: '5'),
    AssetItem(path: 'assets/svg/feelings.svg', name: '6'),
  ].obs;

  @override
  Future<void> onInit() async {
    speechToText = SpeechToText();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void listen() async {
    if (!isListening.value) {
      bool available = await speechToText!.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => authManager.commonTools.showWarningSnackBar(
              'Sorry, we can\'t detect the word, please try again!'));
      if (available) {
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
                () => Future.delayed(Duration(milliseconds: 3800), () {
                      if (text.value.isNotEmpty) {
                        Get.back();
                        searchForCategories();
                      } else {
                        authManager.commonTools.showWarningSnackBar(
                            'Sorry, we can\'t detect the word, please try again!');
                      }
                    }));
      }
    } else {
      isListening.value = false;
      speechToText!.stop();
    }
  }

  searchForCategories() {
    var data = authManager.storage.read('localSelectedCategories');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);
    List<CategoryItem> categories = [];

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
                    text.value.toLowerCase()))
            .toList());

    if (categories.isNotEmpty) {
      Get.to(() => CategoryBySearchView(),
          binding: CategoryBySearchBinding(),
          arguments: [text.value.toLowerCase()]);
    } else {
      authManager.commonTools
          .showWarningSnackBar('There is no result for ${text.value}');
    }
  }
}
