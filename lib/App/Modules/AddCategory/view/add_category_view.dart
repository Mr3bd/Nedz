import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/AddCategory/controller/add_category_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Widgets/survey_item.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primary),
        title: Text('Add Items To ${controller.title}'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 2.0,
        titleTextStyle:
            Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      ),
      body: Obx(() => controller.noSelectedList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 64.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        controller.title,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 24.0,
                            mainAxisSpacing: 24.0,
                            childAspectRatio: 1.1),
                    itemCount: controller.noSelectedList.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => SurveyItem(
                          path: controller.noSelectedList[index].path!,
                          selected: controller.selectedCategories
                              .where((cat) =>
                                  cat.iconPath ==
                                  controller.noSelectedList[index].path!)
                              .isNotEmpty,
                          onTap: () => controller.addToSelectedCateogry(
                              controller.noSelectedList[index].path!,
                              controller.arguments[0],
                              controller.noSelectedList[index].name!),
                        ),
                      );
                    },
                  ).marginAll(15.0),
                ],
              ),
            )
          : Center(
              child: Text('There are no items to add!'),
            )),
      floatingActionButton: controller.noSelectedList.isNotEmpty
          ? Container(
              width: Get.width * 0.6,
              height: Get.width * 0.1,
              margin: const EdgeInsets.only(bottom: 32.0),
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
                      await controller.addSelectedCategoriesToChild();
                    },
                    child: Text(
                      "Confirm",
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline6!.copyWith(
                        color: Colors.white,
                      ),
                    )),
              ),
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
