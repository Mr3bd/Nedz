import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/ABFeelings/controller/ab_feelings_controller.dart';
import 'package:neds/App/Modules/ABFeelings/widget/feeling_count_item.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class ABFeelingsView extends GetView<ABFeelingsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.primary),
            title: Text(controller.curentChild.value.name != null
                ? '${controller.curentChild.value.name}\'s Data'
                : ''),
            centerTitle: true,
            backgroundColor: AppColors.white,
            elevation: 2.0,
            titleTextStyle:
                Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
          ),
          body: Center(
            child: Container(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  controller.feelingCounts.length >= 6
                      ? Container(
                          height: Get.width * 0.61,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.feelingCounts.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (controller
                                        .feelingCounts[index].feelingName ==
                                    null) {
                                  controller.feelingCounts.forEach((element) {
                                    print(element.toJson());
                                  });
                                }
                                return Container(
                                  child: FeelingCountItem(
                                      path: controller.getCorrectEmojiPath(
                                          controller.feelingCounts[index]
                                              .feelingName!),
                                      percentage:
                                          controller.countsSummation.value == 0
                                              ? 0
                                              : controller.feelingCounts[index]
                                                      .counts! /
                                                  controller
                                                      .countsSummation.value),
                                );
                              }),
                        )
                      : SizedBox()
                ],
              ),
            ),
          )),
    );
  }
}
