import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "About Us",
                  style: TextStyle(
                      fontSize: 34,
                      color: Colors.black,
                      fontFamily: 'Atma',
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors().mgreen, width: 2),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().dblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Don't force autistic kids to change in a way to fit this world, but change this world in the way they can fit.",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().vdblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().dblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Nedz is a unique application that focuses on knowing what the autistic's needs are, "
                        "it's not an educational app that aims to change them but accepts their changes. "
                        "Our goal was to use AI and machine learning on autistic kids using voice recognition and photo labeling."
                        " It can also detect the kid's emotions by counting the times of the emojis he chooses in the emojis category that is shown in the Data field."
                        " Nedz can inform parents or caregivers what the kid chooses by sending an email for the thing he picked. ",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().vdblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().dblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Thanks to the \"One Step Forward\" center for helping us by upgrading the idea with their experience & allowed us to deal with their autistic kids.",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().vdblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().dblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Nedz was created in July 2022 by PSUT university students. ",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().vdblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().dblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Nedz founders: Abdullrahman Wasfi & Layan AlHimsi    ",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().vdblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColors().dblue,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
