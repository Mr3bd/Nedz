import 'package:neds/App/Modules/AddCategory/binding/add_category_binding.dart';
import 'package:neds/App/Modules/AddCategory/view/add_category_view.dart';
import 'package:neds/App/Modules/Category/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/SelectedCategory/binding/selected_category_binding.dart';
import 'package:neds/App/Modules/SelectedCategory/view/selected_category_view.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Widgets/category_circle_choice_item.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text(controller.getPageTitle()),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 64.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32.0,
                    mainAxisSpacing: 32.0,
                    childAspectRatio: 1.4),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => CategoryCircleChoiceItem(
                      path: controller.categories[index].iconPath!,
                      onTap: () async {
                        if (controller.categories[index].type != 99 &&
                            controller.categories[index].type != 6) {
                          print('1');
                          Get.to(() => SelectedCategoryView(),
                              binding: SelectedCategoryBinding(),
                              arguments: [controller.arguments[0], index]);
                        } else if (controller.arguments[0] == 6) {
                          controller.authManager.api.sendNotification(
                              'Nedz\n${controller.currentChild.value.name} feels ${controller.categories[index].realName}',
                              controller.currentChild.value.phone!);
                          await controller
                              .addCount(controller.categories[index].realName!)
                              .then((value) => Get.back());
                        } else if (controller.categories[index].type == 99) {
                          print('3');

                          Get.to(() => AddCategoryView(),
                              binding: AddCategoryBinding(),
                              arguments: [controller.arguments[0]]);
                        }
                      },
                    ),
                  );
                },
              ).marginAll(15.0),
            ],
          ),
        ),
      ),
    );
  }
}
