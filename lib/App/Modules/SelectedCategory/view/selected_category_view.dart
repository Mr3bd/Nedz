import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:neds/App/Modules/SelectedCategory/controller/selected_category_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class SelectedCategoryView extends GetView<SelectedCategoryController> {
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
          elevation: controller.getPageTitle() == '' ? 0.0 : 2.0,
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
                      SvgPicture.asset(
                        controller.categoryController
                            .categories[controller.arguments[1]].iconPath!,
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
                              // controller.authManager.api.sendNotification(
                              //     '${controller.currentChild.value.name} does not want ${controller.categoryController.categories[controller.arguments[1]].realName}',
                              //     controller.currentChild.value.phone!);
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
                                  '${controller.currentChild.value.name} wants ${controller.categoryController.categories[controller.arguments[1]].realName}',
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
            (controller.index.value >= 0)
                ? Text(controller.categories[controller.index.value].nickName ??
                    '')
                : SizedBox(),
            Align(
              alignment: Alignment.bottomRight,
              child: AvatarGlow(
                animate: controller.isListening.value,
                glowColor: Theme.of(context).primaryColor,
                endRadius: 50.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: FloatingActionButton(
                    onPressed: () => controller.listen(context),
                    child: SvgPicture.asset('assets/svg/microphone.svg')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
