import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:neds/App/Modules/Dictionary/controller/dictionary_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class DictionaryView extends GetView<DictionaryController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text(controller.curentChild.value.name != null
              ? '${controller.curentChild.value.name}\'s Dictionary'
              : ''),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        body: GroupedListView<dynamic, String>(
          elements: controller.categories,
          groupBy: (element) => element.nickName.toLowerCase(),
          groupSeparatorBuilder: (String groupByValue) => Text(
            groupByValue,
            style: TextStyle(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold),
          ).marginOnly(top: 32.0, bottom: 12.0, left: 16.0),
          itemBuilder: (context, dynamic element) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              element.iconPath.contains('data/user')
                  ? Image.file(
                      File(element.iconPath),
                      width: Get.width * 0.5,
                    )
                  : SvgPicture.asset(
                      element.iconPath,
                      width: Get.width * 0.1,
                      height: Get.width * 0.1,
                    ),
              SizedBox(
                height: 12.0,
              ),
              Text(element.realName),
            ],
          ).marginOnly(bottom: 32.0, left: 16.0),
        ).marginSymmetric(vertical: 16.0),
      ),
    );
  }
}
