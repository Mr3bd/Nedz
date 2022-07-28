import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neds/App/Models/Main/CategoryItem.dart';
import 'package:neds/App/Modules/AddCategoryFromLocal/controller/add_category_from_local_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class AddCategorFromLocalView extends GetView<AddCategoryFromLocalController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.authManager.commonTools.unFocusKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text('Add Item'),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: Obx(
              () => Container(
                width: Get.width,
                child: !controller.firstDataEntered.value
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.selected.value
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 32.0,
                                    ),
                                    Image.file(
                                      File(controller.image.path),
                                      width: Get.width * 0.6,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.image = XFile('');
                                        controller.selected.value = false;
                                        controller.sccaned.value = false;
                                        controller.imageLabels.clear();
                                        controller.categoryItem.value =
                                            CategoryItem(
                                          apId:
                                              controller.currentChild.value.id,
                                          type: 100,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.black
                                                .withOpacity(0.3)),
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.red,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 35.0,
                          ),
                          !controller.selected.value
                              ? Container(
                                  width: Get.width * 0.3,
                                  height: Get.width * 0.3,
                                  child: GestureDetector(
                                      onTap: controller.getImage,
                                      child: SvgPicture.asset(
                                          'assets/svg/add-image.svg')),
                                )
                              : SizedBox(),
                          controller.selected.value
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (controller.selected.value) {
                                            controller.processImage();
                                          }
                                        },
                                        child: const Text('Scan Image')),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          controller.imageLabels.isNotEmpty &&
                                  controller.selected.value
                              ? Container(
                                  width: Get.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'We have found at least one tag for this image, do you want to choose?',
                                        style: Get.textTheme.headline5,
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      ListView.builder(
                                        primary: false,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.imageLabels.length,
                                        itemBuilder: ((context, index) {
                                          return Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                if (controller
                                                        .imageLabels[index] !=
                                                    controller.categoryItem
                                                        .value.realName) {
                                                  controller.categoryItem
                                                      .update((val) {
                                                    val!.realName = controller
                                                        .imageLabels[index];
                                                  });

                                                  controller.categoryItem.value
                                                          .realName =
                                                      controller
                                                          .imageLabels[index];
                                                } else {
                                                  controller.categoryItem
                                                      .update((val) {
                                                    val!.realName = null;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 12.0),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors().bblue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                child: Row(
                                                  children: [
                                                    Text(controller
                                                        .imageLabels[index]),
                                                    controller.imageLabels[
                                                                index] ==
                                                            controller
                                                                .categoryItem
                                                                .value
                                                                .realName
                                                        ? Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 8.0,
                                                              ),
                                                              Icon(
                                                                Icons.done,
                                                                color: AppColors
                                                                    .primary,
                                                              )
                                                            ],
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      !controller.imageLabels.contains(
                                              controller
                                                  .categoryItem.value.realName)
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 24.0,
                                                ),
                                                Text(
                                                  'Or you write the appropriate tag for this image',
                                                  style:
                                                      Get.textTheme.headline5,
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                TextField(
                                                  controller: controller
                                                      .realNameController,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    prefixIcon: Icon(Icons.edit,
                                                        color:
                                                            AppColors().mgrey),
                                                    hintText:
                                                        'Write a tag for the image',
                                                    hintStyle: TextStyle(
                                                      color:
                                                          AppColors().lightgrey,
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColors()
                                                              .mgreen,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColors()
                                                              .mgreen,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 64.0,
                                      ),
                                    ],
                                  ),
                                )
                              : controller.selected.value &&
                                      controller.sccaned.value
                                  ? Container(
                                      width: Get.width * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'We have not found a tag for this image, write the appropriate tag for this image',
                                            style: Get.textTheme.headline5,
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          TextField(
                                            controller:
                                                controller.realNameController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(Icons.edit,
                                                  color: AppColors().mgrey),
                                              hintText:
                                                  'Write a tag for the image',
                                              hintStyle: TextStyle(
                                                color: AppColors().lightgrey,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 14.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors().mgreen,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors().mgreen,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 32.0,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                          controller.selected.value && controller.sccaned.value
                              ? Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.authManager.commonTools
                                              .unFocusKeyboard(context);

                                          if (!controller.imageLabels.contains(
                                                  controller.categoryItem.value
                                                      .realName) &&
                                              controller.realNameController.text
                                                  .isEmpty) {
                                            return controller
                                                .authManager.commonTools
                                                .showFailedSnackBar(
                                                    'Please enter a tag for this image');
                                          }

                                          controller.firstDataEntered.value =
                                              true;

                                          if (!controller.imageLabels.contains(
                                              controller.categoryItem.value
                                                  .realName)) {
                                            controller.categoryItem.value
                                                    .realName =
                                                controller
                                                    .realNameController.text;
                                          }

                                          controller.categoryItem.value
                                              .iconPath = controller.image.path;
                                        },
                                        child: const Text('Next')),
                                    const SizedBox(
                                      height: 30.0,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Have your child pronounce the description of these pictures',
                            style: Get.textTheme.headline5,
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Obx(
                            () => AvatarGlow(
                              animate: controller.isListening.value,
                              glowColor: Theme.of(context).primaryColor,
                              endRadius: 50.0,
                              duration: const Duration(milliseconds: 2000),
                              repeatPauseDuration:
                                  const Duration(milliseconds: 100),
                              repeat: true,
                              child: FloatingActionButton(
                                  onPressed: () => controller.listen(context),
                                  child: SvgPicture.asset(
                                      'assets/svg/microphone.svg')),
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 24.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
