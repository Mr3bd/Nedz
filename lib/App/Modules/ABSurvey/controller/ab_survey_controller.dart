import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neds/App/Models/Main/AssetItem.dart';
import 'package:neds/App/Models/Main/AutisticPatient.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:get/get.dart';

// 'assets/svg/.svg'
class ABSurveyController extends GetxController {
  final AuthenticationManager authManager = Get.find();
  var arguments = Get.arguments;
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  RxList<AssetItem> fruits = [
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
      ].obs,
      Drinks = [
        AssetItem(path: 'assets/svg/001-apple.svg', name: 'Apple'),
        AssetItem(path: 'assets/svg/004-banana.svg', name: 'Banana'),
        AssetItem(path: 'assets/svg/008-carrot.svg', name: 'Carrot'),
        AssetItem(path: 'assets/svg/010-cherry.svg', name: 'cherry'),
        AssetItem(path: 'assets/svg/013-grape.svg', name: 'Grape'),
        AssetItem(path: 'assets/svg/015-green apple.svg', name: 'Green Apple'),
        AssetItem(path: 'assets/svg/019-lemon.svg', name: 'Lemon'),
        AssetItem(path: 'assets/svg/020-mango.svg', name: 'Mango'),
        AssetItem(path: 'assets/svg/021-orange.svg', name: 'Orange'),
        AssetItem(path: 'assets/svg/023-peach.svg', name: 'Peach'),
        AssetItem(path: 'assets/svg/025-pineapple.svg', name: 'Pineapple'),
        AssetItem(path: 'assets/svg/030-watermelon.svg', name: 'Watermelon'),
        AssetItem(path: 'assets/svg/glass-of-water.svg', name: 'Water'),
      ].obs,
      Food = [
        AssetItem(path: 'assets/svg/burger.svg', name: 'Burger'),
        AssetItem(path: 'assets/svg/chicken-leg.svg', name: 'Chicken Leg'),
        AssetItem(path: 'assets/svg/fried-egg.svg', name: 'Fried Egg'),
        AssetItem(
            path: 'assets/svg/fried-potatoes.svg', name: 'Fried Potatoes'),
        AssetItem(path: 'assets/svg/kebab.svg', name: 'Kebab'),
        AssetItem(path: 'assets/svg/pizza-slice.svg', name: 'Pizza'),
      ].obs,
      Sweets = [
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
      ].obs,
      Toys = [
        AssetItem(path: 'assets/svg/baby-toy.svg', name: 'Dinosaur'),
        AssetItem(path: 'assets/svg/blocks.svg', name: 'Blocks'),
        AssetItem(path: 'assets/svg/book.svg', name: 'Book'),
        AssetItem(path: 'assets/svg/car-toy.svg', name: 'CAr'),
        AssetItem(path: 'assets/svg/crayons.svg', name: 'Crayons'),
        AssetItem(path: 'assets/svg/paper-crafts.svg', name: 'Paper Craft'),
        AssetItem(path: 'assets/svg/sandbox.svg', name: 'Sandbox'),
        AssetItem(path: 'assets/svg/toy-train.svg', name: 'Train'),
      ].obs,
      Emoji = [
        AssetItem(path: 'assets/svg/happy.svg', name: 'Happy'),
        AssetItem(path: 'assets/svg/sleeping.svg', name: 'Sleeping'),
        AssetItem(path: 'assets/svg/angry.svg', name: 'Angry'),
        AssetItem(path: 'assets/svg/sad.svg', name: 'Sad'),
        AssetItem(path: 'assets/svg/injured.svg', name: 'Injured'),
        AssetItem(path: 'assets/svg/in-love.svg', name: 'In Love'),
      ].obs;
  RxList<CategoryItem> selectedCategories = <CategoryItem>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void addToSelectedCateogry(String path, int type, String name) {
    if (selectedCategories.where((cat) => cat.iconPath == path).isEmpty) {
      CategoryItem newCat = CategoryItem(
        apId: arguments[0],
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

  Future<void> addChild() async {
    GetStorage storage = GetStorage();
    var data = storage.read('localAutisticPatients');
    List<dynamic> temp = data == null ? [] : jsonDecode(data);

    List<AutisticPatient> localAutisticPatients = temp.isEmpty
        ? []
        : temp
            .map<AutisticPatient>((jsonItem) {
              return AutisticPatient.fromJson(jsonItem);
            })
            .toList()
            .toList();

    AutisticPatient newAutisticPatient = AutisticPatient(
        id: arguments[0],
        careGiverId: authManager.appUser!.value!.uid,
        name: nameEditingController.text,
        phone: phoneEditingController.text,
        date: DateTime.now().toString());

    localAutisticPatients.add(newAutisticPatient);

    await storage.write(
        'localAutisticPatients', jsonEncode(localAutisticPatients));

    await storage.write('currentChildId${authManager.appUser!.value!.email}',
        newAutisticPatient.id!);
    data = storage.read('localSelectedCategories');

    temp = data == null ? [] : jsonDecode(data);

    List<CategoryItem> localSelectedCategories = temp.isEmpty
        ? []
        : temp.map<CategoryItem>((jsonItem) {
            return CategoryItem.fromJson(jsonItem);
          }).toList();

    localSelectedCategories.addAll(selectedCategories);

    await storage.write(
        'localSelectedCategories', jsonEncode(localSelectedCategories));
    authManager.getAutisticPatients();

    Get.offAll(
      () => DashboardView(),
      binding: DashboardBinding(),
    );
  }
}
