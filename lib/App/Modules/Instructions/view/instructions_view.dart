import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Modules/ABSurvey/binding/ab_survey_binding.dart';
import 'package:neds/App/Modules/ABSurvey/view/ab_survey_view.dart';
import 'package:neds/App/Services/AuthenticationService/Core/manager.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class InstructionsView extends StatelessWidget {
  final AuthenticationManager authManager = Get.find();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Instructions",
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                    fontFamily: 'Atma',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors().mgreen, width: 2),
                ),
                padding: EdgeInsets.all(7),
                child: Column(
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors().vdblue,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "1-Fill the survey with what your autistic kid prefers (you can add more later after setting it up).",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors().vdblue,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    //Text("(you cann add more later after setting it up).",style: TextStyle(fontSize: 20, color: AppColors().dblue,fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),),

                    Text(
                      "",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors().dblue,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "2-Take your time answering the questions that are required please.",
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
                      "3-The survey that will appear will be for the first kid, you can add other kids later and repeat the same process after setting it up",
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
                      "4-After completing the survey open the drawer on the left corner of the main screen and click on help to guide you.",
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
                      "",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors().dblue,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      "Nedz was designed for autistic kids, asperger and for anyone who suffers from a lack of communication!",
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
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: width * 0.45,
                      height: width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors().Nextblue,
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors().Nextbuttonblue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.offAll(() => ABSurveyView(),
                          binding: ABSurveyBinding(),
                          arguments: [
                            authManager.commonTools.createRandom(),
                            false
                          ]);
                    },
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                ],
              ),
              SizedBox(
                height: 64.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*


          
*/