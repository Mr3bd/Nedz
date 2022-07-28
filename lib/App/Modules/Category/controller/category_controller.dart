import 'dart:async';
import 'dart:convert';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Models/Main/FeelingCount.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  RxList<CategoryItem> categories = <CategoryItem>[].obs;
  Rx<AutisticPatient> currentChild = AutisticPatient().obs;
  List<FeelingCount> feelingCounts = [];
  var arguments = Get.arguments;

  @override
  Future<void> onInit() async {
    if (arguments[0] != 6) {
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
                  (cat.type == arguments[0]))
              .toList());

      categories.add(CategoryItem(iconPath: 'assets/svg/add.svg', type: 99));
    } else {
      categories.value = [
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
      ];

      var data = authManager.storage.read('feelingCounts');

      List<dynamic> temp = data == null ? [] : jsonDecode(data);

      feelingCounts.addAll(temp.isEmpty
          ? []
          : temp
              .map<FeelingCount>((jsonItem) {
                return FeelingCount.fromJson(jsonItem);
              })
              .toList()
              .toList());
    }

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    currentChild.value = authManager.getCurrentChild();
    super.onReady();
  }

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

      case 6:
        return 'What do you feel?';

      default:
        return '';
    }
  }

  Future<void> addCount(String feelingName) async {
    int index = feelingCounts.indexWhere((feeling) =>
        (feeling.feelingName == feelingName) &&
        (feeling.apId == authManager.currentChildId.value));
    if (index >= 0) {
      feelingCounts[index].counts = feelingCounts[index].counts! + 1;
      print(feelingCounts[index].counts);
    } else {
      FeelingCount feelingCount = FeelingCount(
        apId: authManager.currentChildId.value,
        feelingName: feelingName,
        counts: 1,
      );
      feelingCounts.add(feelingCount);
    }

    await authManager.storage.write('feelingCounts', jsonEncode(feelingCounts));
  }
}
