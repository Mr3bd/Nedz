import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neds/App/Modules/ABFeelings/binding/ab_feelings_binding.dart';
import 'package:neds/App/Modules/ABFeelings/view/ab_feelings_view.dart';
import 'package:neds/App/Modules/ABSurvey/binding/ab_survey_binding.dart';
import 'package:neds/App/Modules/ABSurvey/view/ab_survey_view.dart';
import 'package:neds/App/Modules/About/view/about_view.dart';
import 'package:neds/App/Modules/AddCategoryFromLocal/binding/add_category_from_local_binding.dart';
import 'package:neds/App/Modules/AddCategoryFromLocal/view/add_category_from_local_view.dart';
import 'package:neds/App/Modules/Category/binding/category_binding.dart';
import 'package:neds/App/Modules/Category/view/category_view.dart';
import 'package:neds/App/Modules/Dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/Dictionary/binding/dictionary_binding.dart';
import 'package:neds/App/Modules/Dictionary/view/dictionary_view.dart';
import 'package:neds/App/Modules/Help/view/help_view.dart';
import 'package:neds/App/Modules/SignIn/binding/signin_binding.dart';
import 'package:neds/App/Modules/SignIn/view/signin_view.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Widgets/category_circle_choice_item.dart';
import 'package:neds/App/Widgets/nedz_alert_dialog.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primary),
          title: Text('Home'),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 2.0,
          titleTextStyle:
              Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
        ),
        drawer: Drawer(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      controller.authManager.appUserData.value.name ?? '',
                      style: Get.textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.all(4.0),
                leading: Icon(
                  Icons.group,
                  size: 20,
                ),
                title: Text(
                  "Children",
                  style: Get.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ).marginSymmetric(horizontal: 12.0),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.authManager.autisticPatients.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (controller.authManager.currentChildId.value !=
                            controller.authManager.autisticPatients[index].id) {
                          controller.authManager.changeCurrentChild(controller
                              .authManager.autisticPatients[index].id!);
                        }
                      },
                      child: Row(
                        children: [
                          Obx(
                            () => Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.authManager
                                              .autisticPatients[index].id ==
                                          controller
                                              .authManager.currentChildId.value
                                      ? AppColors.primary
                                      : AppColors.primary.withOpacity(0.3)),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            children: [
                              Text(
                                controller.authManager.autisticPatients[index]
                                        .name ??
                                    '',
                                style: Get.textTheme.headline6!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ).paddingAll(12.0),
                    );
                  }).marginSymmetric(horizontal: 32.0, vertical: 4.0),
              ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.all(4.0),
                leading: Icon(
                  Icons.add_circle_rounded,
                  size: 20,
                ),
                title: Text(
                  "Add child",
                  style: Get.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Get.to(() => ABSurveyView(),
                      binding: ABSurveyBinding(),
                      arguments: [
                        controller.authManager.commonTools.createRandom(),
                        true
                      ]);
                },
              ).marginSymmetric(horizontal: 12.0),
              ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.all(4.0),
                leading: Icon(
                  Icons.help,
                  size: 20,
                ),
                title: Text(
                  "Help",
                  style: Get.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Get.to(() => HelpView());
                },
              ).marginSymmetric(horizontal: 12.0),
              ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.all(4.0),
                leading: Icon(
                  Icons.info,
                  size: 20,
                ),
                title: Text(
                  "About us",
                  style: Get.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Get.to(() => AboutView());
                },
              ).marginSymmetric(horizontal: 12.0),
              ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.all(4.0),
                leading: Icon(
                  Icons.logout,
                  size: 20,
                ),
                title: Text(
                  "Log out",
                  style: Get.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  await controller.authManager.logOut();
                  Get.offAll(() => SignInView(), binding: SignInBinding());
                },
              ).marginSymmetric(horizontal: 12.0),
            ],
          ),
        ),
        body: Center(
          child: GridView.builder(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 32.0,
                mainAxisSpacing: 32.0,
                childAspectRatio: 1.4),
            itemCount: controller.mainCategories.length,
            itemBuilder: (context, index) {
              return Obx(
                () => CategoryCircleChoiceItem(
                  path: controller.mainCategories[index].path!,
                  onTap: () {
                    Get.to(() => CategoryView(),
                        binding: CategoryBinding(),
                        arguments: [
                          int.parse(controller.mainCategories[index].name!)
                        ]);
                  },
                ),
              );
            },
          ).marginOnly(right: 16.0, left: 16.0, top: 16.0, bottom: 32.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 0,
          overlayColor: Colors.transparent,
          overlayOpacity: 0.0,
          childPadding: const EdgeInsets.all(5),
          closeDialOnPop: true,
          spaceBetweenChildren: 4,
          buttonSize: Size(Get.width * 0.11, Get.width * 0.11),
          childrenButtonSize: Size(Get.width * 0.13, Get.width * 0.13),
          dialRoot: (ctx, open, toggleChildren) {
            return IconButton(
                onPressed: toggleChildren,
                icon: SvgPicture.asset('assets/svg/cogwheel.svg'));
          },
          label: const Text("Open"),
          activeLabel: const Text("Close"),
          onOpen: () => debugPrint('OPENING DIAL'),
          onClose: () => debugPrint('DIAL CLOSED'),
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          elevation: 0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          animationDuration: const Duration(milliseconds: 100),
          shape: const StadiumBorder(),
          direction: SpeedDialDirection.left,
          children: [
            SpeedDialChild(
                child: SvgPicture.asset('assets/svg/microphone.svg'),
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                //  label: 'Microphone',
                visible: true,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => NedzAlertDialog(
                            description: 'Say anything'.tr,
                            AlertIcon: SizedBox(),
                            button: Obx(
                              () => AvatarGlow(
                                animate: controller.isListening.value,
                                glowColor: Theme.of(context).primaryColor,
                                endRadius: 50.0,
                                duration: const Duration(milliseconds: 2000),
                                repeatPauseDuration:
                                    const Duration(milliseconds: 100),
                                repeat: true,
                                child: FloatingActionButton(
                                    onPressed: controller.listen,
                                    child: SvgPicture.asset(
                                        'assets/svg/microphone.svg')),
                              ),
                            ),
                          ));
                }),
            SpeedDialChild(
              child: SvgPicture.asset(
                'assets/svg/photo.svg',
              ),
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              //         label: 'Add Photo',
              onTap: () {
                Get.to(() => AddCategorFromLocalView(),
                    binding: AddCategoryFromLocalBinding());
              },
            ),
            SpeedDialChild(
              child: SvgPicture.asset('assets/svg/bar-graph.svg'),
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              //      label: 'Data',
              onTap: () {
                Get.to(() => ABFeelingsView(), binding: ABFeelingsBinding());
              },
            ),
            SpeedDialChild(
              child: SvgPicture.asset('assets/svg/book1.svg'),
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              //    label: 'Dictionary',
              onTap: () {
                Get.to(() => DictionaryView(), binding: DictionarydBinding());
              },
            ),
          ],
        ).marginSymmetric(horizontal: 16.0, vertical: 24.0),
      ),
    );
  }
}


/*
Obx(
                () => AvatarGlow(
                  animate: controller.isListening.value,
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 0.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: FloatingActionButton(
                      onPressed: controller.listen,
                      child: SvgPicture.asset('assets/svg/microphone.svg')),
                ),

*/
