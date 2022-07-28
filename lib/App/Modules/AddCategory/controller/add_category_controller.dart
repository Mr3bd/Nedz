import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:neds/App/Models/Main/AssetItem.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';

class AddCategoryController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  RxList<AssetItem> noSelectedList = <AssetItem>[].obs;
  RxList<CategoryItem> selectedCategories = <CategoryItem>[].obs;
  RxList<CategoryItem> categories = <CategoryItem>[].obs;
  String title = '';
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
                (cat.type == arguments[0]))
            .toList());
    getCorrectNoSelectedListByTypeId();

    log(noSelectedList.length.toString());
    title = getPageTitle();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void getCorrectNoSelectedListByTypeId() {
    switch (arguments[0]) {
      case 1:
        noSelectedList.addAll([
          AssetItem(path: 'assets/svg/apple.svg', name: 'Apple'),
          AssetItem(path: 'assets/svg/banana.svg', name: 'Banana'),
          AssetItem(path: 'assets/svg/blueberries.svg', name: 'Blueberries'),
          AssetItem(path: 'assets/svg/cherries.svg', name: 'Cherries'),
          AssetItem(path: 'assets/svg/corn.svg', name: 'Corn'),
          AssetItem(path: 'assets/svg/grapes.svg', name: 'Grapes'),
          AssetItem(path: 'assets/svg/lemon.svg', name: 'Lemon'),
          AssetItem(path: 'assets/svg/mango.svg', name: 'Mango'),
          AssetItem(path: 'assets/svg/orange.svg', name: 'Orange'),
          AssetItem(path: 'assets/svg/pineapple.svg', name: 'Pineapple'),
          AssetItem(path: 'assets/svg/red-pepper.svg', name: 'Red Pepper'),
          AssetItem(path: 'assets/svg/strawberry.svg', name: 'Strawberry'),
        ]);

        noSelectedList.removeWhere((asset) =>
            categories.where((cat) => cat.iconPath == asset.path).isNotEmpty);
        return;
      case 2:
        noSelectedList.addAll([
          AssetItem(path: 'assets/svg/001-apple.svg', name: 'Apple'),
          AssetItem(path: 'assets/svg/004-banana.svg', name: 'Banana'),
          AssetItem(path: 'assets/svg/008-carrot.svg', name: 'Carrot'),
          AssetItem(path: 'assets/svg/010-cherry.svg', name: 'cherry'),
          AssetItem(path: 'assets/svg/013-grape.svg', name: 'Grape'),
          AssetItem(
              path: 'assets/svg/015-green apple.svg', name: 'Green Apple'),
          AssetItem(path: 'assets/svg/019-lemon.svg', name: 'Lemon'),
          AssetItem(path: 'assets/svg/020-mango.svg', name: 'Mango'),
          AssetItem(path: 'assets/svg/021-orange.svg', name: 'Orange'),
          AssetItem(path: 'assets/svg/023-peach.svg', name: 'Peach'),
          AssetItem(path: 'assets/svg/025-pineapple.svg', name: 'Pineapple'),
          AssetItem(path: 'assets/svg/030-watermelon.svg', name: 'Watermelon'),
          AssetItem(path: 'assets/svg/glass-of-water.svg', name: 'Water'),
        ]);
        noSelectedList.removeWhere((asset) =>
            categories.where((cat) => cat.iconPath == asset.path).isNotEmpty);
        return;

      case 3:
        noSelectedList.addAll([
          AssetItem(path: 'assets/svg/burger.svg', name: 'Burger'),
          AssetItem(path: 'assets/svg/chicken-leg.svg', name: 'Chicken Leg'),
          AssetItem(path: 'assets/svg/fried-egg.svg', name: 'Fried Egg'),
          AssetItem(
              path: 'assets/svg/fried-potatoes.svg', name: 'Fried Potatoes'),
          AssetItem(path: 'assets/svg/kebab.svg', name: 'Kebab'),
          AssetItem(path: 'assets/svg/pizza-slice.svg', name: 'Pizza'),
        ]);
        noSelectedList.removeWhere((asset) =>
            categories.where((cat) => cat.iconPath == asset.path).isNotEmpty);
        return;

      case 4:
        noSelectedList.addAll([
          AssetItem(path: 'assets/svg/012-gummy-bear.svg', name: 'Gummy Bear'),
          AssetItem(path: 'assets/svg/019-chocolate.svg', name: 'Chocolate'),
          AssetItem(
              path: 'assets/svg/024-chocolate-egg.svg', name: 'Chocolate Egg'),
          AssetItem(path: 'assets/svg/026-cupcake.svg', name: 'Cupcake'),
          AssetItem(path: 'assets/svg/032-lollipop.svg', name: 'Lollipop'),
          AssetItem(path: 'assets/svg/036-popsicle.svg', name: 'Popsicle'),
          AssetItem(path: 'assets/svg/037-honey.svg', name: 'Honey'),
          AssetItem(path: 'assets/svg/038-candy.svg', name: 'Candy'),
          AssetItem(path: 'assets/svg/cotton-candy.svg', name: 'Cotton Candy'),
          AssetItem(path: 'assets/svg/muffin.svg', name: 'Muffin'),
        ]);
        noSelectedList.removeWhere((asset) =>
            categories.where((cat) => cat.iconPath == asset.path).isNotEmpty);
        return;

      case 5:
        noSelectedList.addAll([
          AssetItem(path: 'assets/svg/baby-toy.svg', name: 'Dinosaur'),
          AssetItem(path: 'assets/svg/blocks.svg', name: 'Blocks'),
          AssetItem(path: 'assets/svg/book.svg', name: 'Book'),
          AssetItem(path: 'assets/svg/car-toy.svg', name: 'CAr'),
          AssetItem(path: 'assets/svg/crayons.svg', name: 'Crayons'),
          AssetItem(path: 'assets/svg/paper-crafts.svg', name: 'Paper Craft'),
          AssetItem(path: 'assets/svg/sandbox.svg', name: 'Sandbox'),
          AssetItem(path: 'assets/svg/toy-train.svg', name: 'Train'),
        ]);
        noSelectedList.removeWhere((asset) =>
            categories.where((cat) => cat.iconPath == asset.path).isNotEmpty);
        return;

      default:
    }
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

  void addToSelectedCateogry(String path, int type, String name) {
    if (selectedCategories.where((cat) => cat.iconPath == path).isEmpty) {
      CategoryItem newCat = CategoryItem(
        apId: authManager.currentChildId.value,
        iconPath: path,
        type: type,
        realName: name,
        nickName: null,
      );
      selectedCategories.add(newCat);
    } else {
      selectedCategories.removeWhere((cat) => cat.iconPath == path);
    }
  }

  Future<void> addSelectedCategoriesToChild() async {
    var data = authManager.storage.read('localSelectedCategories');

    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    List<CategoryItem> localSelectedCategories = temp.isEmpty
        ? []
        : temp.map<CategoryItem>((jsonItem) {
            return CategoryItem.fromJson(jsonItem);
          }).toList();

    print(selectedCategories.length);
    localSelectedCategories.addAll(selectedCategories);
    AutisticPatient sf = authManager.getCurrentChild();
    print(sf.name);
    await authManager.storage
        .write('localSelectedCategories', jsonEncode(localSelectedCategories));

    Get.offAll(() => DashboardView(), binding: DashboardBinding());
  }
}
