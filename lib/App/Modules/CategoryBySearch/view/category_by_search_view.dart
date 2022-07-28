import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/CategoryBySearch/controller/category_by_search_controller.dart';
import 'package:neds/App/Modules/SelectedCategoryBySearch/binding/selected_category_by_search_binding.dart';
import 'package:neds/App/Modules/SelectedCategoryBySearch/view/selected_category_by_search_view.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Widgets/category_circle_choice_item.dart';

class CategoryBySearchView extends GetView<CategoryBySearchController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text('Items'),
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
                        Get.to(() => SelectedCategoryBySearchView(),
                            binding: SelectedCategoryBySearchBinding(),
                            arguments: [index]);
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
