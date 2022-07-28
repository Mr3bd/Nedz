import 'package:neds/App/Modules/ForgetPassword/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.authManager.commonTools.unFocusKeyboard(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: Get.width,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 170,
                  ),
                  Text(
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 34,
                        color: Colors.black,
                        fontFamily: 'Atma',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      color: AppColors().mgreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                                Icon(Icons.email, color: AppColors().mgrey),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: AppColors().lightgrey,
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors().mgreen, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors().mgreen, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: Get.width * 0.85,
                      height: Get.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors().bblue,
                      ),
                      child: Center(
                        child: Text(
                          "Reset Link",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (controller.emailController.text.isNotEmpty) {
                        controller.authManager.commonTools.showLoading();
                        bool result = await controller
                            .authManager.firebaseServices
                            .resetPassword(
                                email: controller.emailController.text);
                        Get.back();
                        if (result) {
                          controller.emailController.clear();
                          Get.back();
                          controller.authManager.commonTools
                              .showSuccessSnackBar(
                                  'Reset link has been sent to you email');
                        } else {
                          controller.authManager.commonTools.showFailedSnackBar(
                              'There is an error in your data');
                        }
                      } else {
                        controller.authManager.commonTools
                            .showFailedSnackBar('Please enter your email');
                      }
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: Get.width * 0.85,
                        height: Get.width * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors().bblue,
                        ),
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.back();
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
