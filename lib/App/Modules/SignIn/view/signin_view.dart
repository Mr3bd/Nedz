import 'package:flutter_svg/flutter_svg.dart';
import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';
import 'package:neds/App/Modules/ForgetPassword/binding/forget_password_binding.dart';
import 'package:neds/App/Modules/ForgetPassword/view/forget_password_view.dart';
import 'package:neds/App/Modules/SignIn/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/SignUp/binding/sign_up_binding.dart';
import 'package:neds/App/Modules/SignUp/view/sign_up_view.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.authManager.commonTools.unFocusKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
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
                          const SizedBox(height: 25),
                          const Text(
                            'Nedz',
                            style: TextStyle(
                                fontSize: 34,
                                color: Colors.black,
                                fontFamily: 'Atma',
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 25),
                          TextFormField(
                              autofocus: false,
                              controller: controller.emailController,
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
                                controller.emailController.text = value!;
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
                          const SizedBox(height: 16.0),
                          TextFormField(
                              autofocus: false,
                              controller: controller.passwordController,
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
                                controller.passwordController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
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
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ForgetPasswordView(),
                                        binding: ForgetPasswordBinding());
                                  },
                                  child: Text(
                                    "Forget Password? ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                          const SizedBox(height: 32.0),
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
                                        .hasMatch(
                                            controller.emailController.text)) {
                                      return controller.authManager.commonTools
                                          .showFailedSnackBar(
                                              'Please enter valid email');
                                    }

                                    if (!RegExp(r'^.{6,}$').hasMatch(
                                        controller.passwordController.text)) {
                                      return controller.authManager.commonTools
                                          .showFailedSnackBar(
                                              'Enter Valid Password(Min. 6 Character)');
                                    }

                                    if (controller
                                            .emailController.text.isNotEmpty &&
                                        controller.passwordController.text
                                            .isNotEmpty) {
                                      controller.authManager.commonTools
                                          .showLoading();
                                      bool result = await controller
                                          .authManager.firebaseServices
                                          .signIn(
                                              controller.emailController.text,
                                              controller
                                                  .passwordController.text);
                                      Get.back();

                                      if (result) {
                                        controller.authManager
                                            .getAutisticPatients();
                                        Get.offAll(() => DashboardView(),
                                            binding: DashboardBinding());
                                        controller.authManager.commonTools
                                            .showSuccessSnackBar(
                                                'You are logged in successfully');
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
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 16.0),
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
                                  onPressed: () {
                                    Get.to(() => SignUpView(),
                                        binding: SignUpBinding());
                                  },
                                  child: Text(
                                    "Create new account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 32.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
