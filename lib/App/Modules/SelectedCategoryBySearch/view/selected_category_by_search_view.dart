import 'dart:io';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:neds/App/Modules/SelectedCategoryBySearch/controller/selected_category_by_search_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class SelectedCategoryBySearchView
    extends GetView<SelectedCategoryBySearchController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text(controller.categoryBySearchController
                  .categories[controller.arguments[0]].nickName ??
              ''),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 64,
                      ),
                      controller.categoryBySearchController
                              .categories[controller.arguments[0]].iconPath!
                              .contains('data/user')
                          ? Image.file(
                              File(controller
                                  .categoryBySearchController
                                  .categories[controller.arguments[0]]
                                  .iconPath!),
                              width: Get.width * 0.6,
                            )
                          : SvgPicture.asset(
                              controller
                                  .categoryBySearchController
                                  .categories[controller.arguments[0]]
                                  .iconPath!,
                              width: Get.width * 0.4,
                              height: Get.width * 0.4,
                            ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.offAll(() => DashboardView(),
                                  binding: DashboardBinding());
                            },
                            child: Image.asset(
                              'assets/img/no.png',
                              width: Get.width * 0.3,
                              height: Get.width * 0.3,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          InkWell(
                            onTap: () {
                              controller.authManager.api.sendNotification(
                                  '${controller.currentChild.value.name} wants ${controller.categoryBySearchController.categories[controller.arguments[0]].realName}',
                                  controller.currentChild.value.phone!);
                              Get.offAll(() => DashboardView(),
                                  binding: DashboardBinding());
                            },
                            child: Image.asset(
                              'assets/img/yes.png',
                              width: Get.width * 0.3,
                              height: Get.width * 0.3,
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 32.0)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
