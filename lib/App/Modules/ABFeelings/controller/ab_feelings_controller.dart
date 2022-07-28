import 'dart:convert';

import 'package:get/get.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/FeelingCount.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';

class ABFeelingsController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  Rx<AutisticPatient> curentChild = AutisticPatient().obs;
  RxList<FeelingCount> feelingCounts = <FeelingCount>[].obs;
  RxInt countsSummation = 0.obs;

  @override
  Future<void> onInit() async {
    curentChild.value = authManager.getCurrentChild();

    var data = authManager.storage.read('feelingCounts');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    feelingCounts.addAll(temp.isEmpty
        ? []
        : temp
            .map<FeelingCount>((jsonItem) {
              return FeelingCount.fromJson(jsonItem);
            })
            .toList()
            .where((feeling) => feeling.apId == curentChild.value.id)
            .toList());
    addZeros();
    feelingCounts.forEach((feeling) {
      countsSummation.value += feeling.counts ?? 0;
    });
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void addZeros() {
    if (feelingCounts
        .where((feeling) => feeling.feelingName == 'happy')
        .isEmpty) {
      feelingCounts.add(FeelingCount(counts: 0, feelingName: 'happy'));
    }

    if (feelingCounts
        .where((feeling) => feeling.feelingName == 'sleeping')
        .isEmpty) {
      feelingCounts.add(FeelingCount(counts: 0, feelingName: 'sleeping'));
    }

    if (feelingCounts
        .where((feeling) => feeling.feelingName == 'In Love')
        .isEmpty) {
      feelingCounts.add(FeelingCount(counts: 0, feelingName: 'In Love'));
    }

    if (feelingCounts
        .where((feeling) => feeling.feelingName == 'angry')
        .isEmpty) {
      feelingCounts.add(FeelingCount(counts: 0, feelingName: 'angry'));
    }

    if (feelingCounts
        .where((feeling) => feeling.feelingName == 'sad')
        .isEmpty) {
      feelingCounts.add(FeelingCount(counts: 0, feelingName: 'sad'));
    }

    if (feelingCounts
        .where((feeling) => feeling.feelingName == 'injured')
        .isEmpty) {
      feelingCounts.add(FeelingCount(counts: 0, feelingName: 'injured'));
    }
  }

  String getCorrectEmojiPath(String feelingName) {
    switch (feelingName) {
      case 'happy':
        return 'assets/svg/happy.svg';

      case 'sleeping':
        return 'assets/svg/sleeping.svg';

      case 'In Love':
        return 'assets/svg/in-love.svg';

      case 'angry':
        return 'assets/svg/angry.svg';

      case 'sad':
        return 'assets/svg/sad.svg';

      case 'injured':
        return 'assets/svg/injured.svg';

      default:
        return '';
    }
  }
}


/*

  CategoryItem(
            iconPath: 'assets/svg/happy.svg', type: 6, realName: 'happy'),
        CategoryItem(
            iconPath: 'assets/svg/sleeping.svg', type: 6, realName: 'sleeping'),
        CategoryItem(
            iconPath: 'assets/svg/in-love.svg', type: 6, realName: 'In Love'),
        CategoryItem(
            iconPath: 'assets/svg/angry.svg', type: 6, realName: 'angry'),
        CategoryItem(iconPath: 'assets/svg/sad.svg', type: 6, realName: 'sad'),
        CategoryItem(
            iconPath: 'assets/svg/injured.svg', type: 6, realName: 'injured'),

*/
