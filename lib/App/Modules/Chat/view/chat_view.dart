import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/Chat/controller/chat_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Utilities/Constants/AppStyles.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text('Chat'),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        body: Obx(
          () => ListView(
            children: [
              MessageWidget(text: 'Is the kid angry?'),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (controller.firstQuestion.value != 0 &&
                          controller.firstQuestion.value != 1)
                      ? SizedBox()
                      : Container(
                          width: Get.width * 0.3,
                          child: InkWell(
                            onTap: () async {
                              if (controller.firstQuestion.value == 0) {
                                controller.firstQuestion.value = 1;
                                await controller.addCount('angry');
                              }
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child:
                                  Text('Yes', style: Get.textTheme.headline5!),
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 12.0,
                  ),
                  (controller.firstQuestion.value != 0 &&
                          controller.firstQuestion.value != 2)
                      ? SizedBox()
                      : Container(
                          width: Get.width * 0.3,
                          child: InkWell(
                            onTap: () async {
                              if (controller.firstQuestion.value == 0) {
                                controller.firstQuestion.value = 2;
                                await controller.addCount('sad');
                              }
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child:
                                  Text('No', style: Get.textTheme.headline5!),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: controller.firstQuestion.value == 1 ? 16.0 : 0.0,
              ),
              controller.firstQuestion.value == 1
                  ? MessageWidget(
                      text:
                          'If one of the suggestions were the reason select it please')
                  : SizedBox(),
              controller.firstQuestion.value == 1
                  ? Container(
                      height: Get.width * 0.3,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.angryList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                      boxShadow: [AppStyles.primaryShadow],
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.black.withOpacity(0.2),
                                      )),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.angryList[index] ==
                                            'Other') {
                                          controller.gotCorrectResult.value = 2;
                                        } else {
                                          controller.gotCorrectResult.value = 1;
                                        }
                                      },
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child:
                                            Text(controller.angryList[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    )
                  : SizedBox(),
              SizedBox(
                height: controller.firstQuestion.value == 2 ? 16.0 : 0.0,
              ),
              controller.firstQuestion.value == 2
                  ? MessageWidget(text: 'Is the kid sad or nervous ?')
                  : SizedBox(),
              SizedBox(
                height: controller.firstQuestion.value == 2 ? 16.0 : 0.0,
              ),
              controller.firstQuestion.value == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (controller.secondQuestion.value != 0 &&
                                controller.secondQuestion.value != 1)
                            ? SizedBox()
                            : Container(
                                width: Get.width * 0.3,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.secondQuestion.value == 0) {
                                      controller.secondQuestion.value = 1;
                                    }
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: Text('Yes',
                                        style: Get.textTheme.headline5!),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 12.0,
                        ),
                        (controller.secondQuestion.value != 0 &&
                                controller.secondQuestion.value != 2)
                            ? SizedBox()
                            : Container(
                                width: Get.width * 0.3,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.secondQuestion.value == 0) {
                                      controller.secondQuestion.value = 2;
                                    }
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: Text('No',
                                        style: Get.textTheme.headline5!),
                                  ),
                                ),
                              ),
                      ],
                    )
                  : SizedBox(),
              controller.secondQuestion.value == 1
                  ? Container(
                      height: Get.width * 0.3,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.sadList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                      boxShadow: [AppStyles.primaryShadow],
                                      border: Border.all(
                                        width: 1.0,
                                        color: Colors.black.withOpacity(0.2),
                                      )),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.sadList[index] ==
                                            'Other') {
                                          controller.gotCorrectResult.value = 2;
                                        } else {
                                          controller.gotCorrectResult.value = 1;
                                        }
                                      },
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(controller.sadList[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    )
                  : SizedBox(),
              ((controller.gotCorrectResult.value == 1) &&
                      (controller.firstQuestion.value == 1 ||
                          controller.secondQuestion.value == 1))
                  ? MessageWidget(
                      text: 'That\'s great! Nedz is always for help.')
                  : (((controller.gotCorrectResult.value == 2) &&
                              (controller.firstQuestion.value == 1 ||
                                  controller.secondQuestion.value == 1))) ||
                          (controller.firstQuestion.value == 2 &&
                              controller.secondQuestion.value == 2)
                      ? MessageWidget(text: 'We are sorry... We hope can help!')
                          .marginOnly(
                              top: (controller.firstQuestion.value == 2 &&
                                      controller.secondQuestion.value == 2)
                                  ? 12.0
                                  : 0.0)
                      : SizedBox(),
            ],
          ).marginSymmetric(horizontal: 16.0, vertical: 16.0),
        ));
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  MessageWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: Get.width * 0.7,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(20),
              topEnd: Radius.circular(20),
              topStart: Radius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: Get.textTheme.headline5!.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
