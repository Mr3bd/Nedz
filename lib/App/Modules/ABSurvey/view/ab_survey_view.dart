import 'package:neds/App/Modules/ABSurvey/controller/ab_survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Widgets/survey_item.dart';

class ABSurveyView extends GetView<ABSurveyController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.authManager.commonTools.unFocusKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          automaticallyImplyLeading: controller.arguments[1],
          title: Text('Add Child'),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  'Survey',
                  style: Get.textTheme.headline3!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '1) Please enter the kid name',
                        style: Get.textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    autofocus: false,
                    controller: controller.nameEditingController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("Name cannot be Empty");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.nameEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                      hintText: "Kid Name",
                      hintStyle: TextStyle(
                        color: AppColors().lightgrey,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors().mgreen, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors().mgreen, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )).marginSymmetric(horizontal: 40.0),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '2) Please fill the survey with what the kid prefers? (you can choose more than one)',
                        style: Get.textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Fruits',
                      style: Get.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 24.0,
                      childAspectRatio: 1.1),
                  itemCount: controller.fruits.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SurveyItem(
                        path: controller.fruits[index].path!,
                        selected: controller.selectedCategories
                            .where((cat) =>
                                cat.iconPath == controller.fruits[index].path!)
                            .isNotEmpty,
                        onTap: () => controller.addToSelectedCateogry(
                            controller.fruits[index].path!,
                            1,
                            controller.fruits[index].name!),
                      ),
                    );
                  },
                ).marginAll(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Drinks',
                      style: Get.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 24.0,
                      childAspectRatio: 1.1),
                  itemCount: controller.Drinks.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SurveyItem(
                        path: controller.Drinks[index].path!,
                        selected: controller.selectedCategories
                            .where((cat) =>
                                cat.iconPath == controller.Drinks[index].path!)
                            .isNotEmpty,
                        onTap: () => controller.addToSelectedCateogry(
                            controller.Drinks[index].path!,
                            2,
                            controller.Drinks[index].name!),
                      ),
                    );
                  },
                ).marginAll(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Food',
                      style: Get.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 24.0,
                      childAspectRatio: 1.1),
                  itemCount: controller.Food.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SurveyItem(
                        path: controller.Food[index].path!,
                        selected: controller.selectedCategories
                            .where((cat) =>
                                cat.iconPath == controller.Food[index].path!)
                            .isNotEmpty,
                        onTap: () => controller.addToSelectedCateogry(
                            controller.Food[index].path!,
                            3,
                            controller.Food[index].name!),
                      ),
                    );
                  },
                ).marginAll(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sweets',
                      style: Get.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 24.0,
                      childAspectRatio: 1.1),
                  itemCount: controller.Sweets.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SurveyItem(
                        path: controller.Sweets[index].path!,
                        selected: controller.selectedCategories
                            .where((cat) =>
                                cat.iconPath == controller.Sweets[index].path!)
                            .isNotEmpty,
                        onTap: () => controller.addToSelectedCateogry(
                            controller.Sweets[index].path!,
                            4,
                            controller.Sweets[index].name!),
                      ),
                    );
                  },
                ).marginAll(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Toys',
                      style: Get.textTheme.headline4!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24.0,
                      mainAxisSpacing: 24.0,
                      childAspectRatio: 1.1),
                  itemCount: controller.Toys.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SurveyItem(
                        path: controller.Toys[index].path!,
                        selected: controller.selectedCategories
                            .where((cat) =>
                                cat.iconPath == controller.Toys[index].path!)
                            .isNotEmpty,
                        onTap: () => controller.addToSelectedCateogry(
                            controller.Toys[index].path!,
                            5,
                            controller.Toys[index].name!),
                      ),
                    );
                  },
                ).marginAll(15.0),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '3) Please enter a phone to receive notifications about your children',
                        style: Get.textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 40.0),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    autofocus: false,
                    controller: controller.phoneEditingController,
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      controller.phoneEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                      hintText: "Phone eg: +962791194447",
                      hintStyle: TextStyle(
                        color: AppColors().lightgrey,
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors().mgreen, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors().mgreen, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )).marginSymmetric(horizontal: 40.0),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  width: Get.width * 0.6,
                  height: Get.width * 0.1,
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.purple,
                    child: MaterialButton(
                        padding: const EdgeInsets.all(4.0),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          controller.authManager.commonTools
                              .unFocusKeyboard(context);
                          if (controller
                                  .nameEditingController.text.isNotEmpty &&
                              controller
                                  .phoneEditingController.text.isNotEmpty) {
                            await controller.addChild();
                          } else {
                            controller.authManager.commonTools
                                .showFailedSnackBar('Please enter all fields');
                          }
                        },
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 64.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
