import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/Instructions/view/instructions_view.dart';
import 'package:neds/App/Modules/SignUp/controller/sign_up_controller.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            // passing this to our root
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 120,
                            child: SvgPicture.asset(
                              "assets/svg/logo.svg",
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(height: 45),
                        TextFormField(
                            autofocus: false,
                            controller: controller.nameEditingController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{3,}$');
                              if (value!.isEmpty) {
                                return ("Name cannot be Empty");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid name(Min. 3 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.nameEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                              hintText: "Name",
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
                            )),
                        const SizedBox(height: 20),
                        TextFormField(
                            autofocus: false,
                            controller: controller.emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Email");
                              }
                              // reg expression for email validation
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.emailEditingController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.mail,
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                              hintText: "Email",
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
                            )),
                        const SizedBox(height: 20),
                        TextFormField(
                            autofocus: false,
                            controller: controller.passwordEditingController,
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              controller.passwordEditingController.text =
                                  value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                              hintText: "Password",
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
                            )),
                        const SizedBox(height: 20),
                        Container(
                          width: Get.width * 0.6,
                          height: Get.width * 0.1,
                          child: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColors().bblue,
                            child: MaterialButton(
                                padding: const EdgeInsets.all(4.0),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(controller
                                          .emailEditingController.text)) {
                                    return controller.authManager.commonTools
                                        .showFailedSnackBar(
                                            'Please enter valid email');
                                  }

                                  if (!RegExp(r'^.{6,}$').hasMatch(controller
                                      .passwordEditingController.text)) {
                                    return controller.authManager.commonTools
                                        .showFailedSnackBar(
                                            'Enter Valid Password(Min. 6 Character)');
                                  }

                                  if (controller.nameEditingController.text
                                          .isNotEmpty &&
                                      controller.emailEditingController.text
                                          .isNotEmpty &&
                                      controller.passwordEditingController.text
                                          .isNotEmpty) {
                                    controller.isLoading.value = true;
                                    bool result = await controller
                                        .authManager.firebaseServices
                                        .signUp(
                                            controller
                                                .nameEditingController.text,
                                            controller
                                                .emailEditingController.text,
                                            controller.passwordEditingController
                                                .text);
                                    controller.isLoading.value = false;

                                    if (result) {
                                      Get.offAll(
                                        () => InstructionsView(),
                                      );

                                      controller.authManager.commonTools
                                          .showSuccessSnackBar(
                                              'Account has been registered successfully');
                                    } else {
                                      controller.authManager.commonTools
                                          .showFailedSnackBar(
                                              'There is an error in your data');
                                    }
                                  } else {
                                    controller.authManager.commonTools
                                        .showFailedSnackBar(
                                            'Please enter all fields');
                                  }
                                },
                                child: Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            controller.isLoading.value
                ? Center(
                    child: Container(
                    width: Get.width * 0.15,
                    height: Get.width * 0.15,
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: CupertinoActivityIndicator(),
                  ))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
