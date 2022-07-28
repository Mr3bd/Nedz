import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Widgets/HelpSingleItem.dart';
import 'package:neds/App/Widgets/text_in.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: ListView(scrollDirection: Axis.vertical, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Help",
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                    fontFamily: 'Atma',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 20),
                  width: Get.width * 0.1,
                  height: Get.width * 0.1,
                  child: SvgPicture.asset('assets/svg/cogwheel.svg'),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, bottom: 20),
                  child: Text(
                    "Settings:"
                    "",
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors().vdblue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
          HelpSingleItem(
              path: 'assets/svg/microphone.svg',
              title: 'Microphone: searches for the word he is saying'),
          HelpSingleItem(
              path: 'assets/svg/photo.svg',
              title: 'Add photo: He can capture or add a photo for the things'
                  ' he wants to save in his own dictionary'),
          HelpSingleItem(
              path: 'assets/svg/speech-bubble.svg',
              title: 'Chat: suggestions that are given to know why the kid '
                  'is in a bad mood'),
          HelpSingleItem(
              path: 'assets/svg/bar-graph.svg',
              title:
                  'Data: counts the number of times he chooses the emoji and graph it'),
          HelpSingleItem(
              path: 'assets/svg/book.svg',
              title:
                  'Dictionary: the place where pictures & icons are saved in '
                  'the way he says it'),
          Container(
            margin: EdgeInsets.only(left: 20, top: 30),
            child: Text(
              "Steps:",
              style: TextStyle(
                  fontSize: 30,
                  color: AppColors().vdblue,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextIn(
              title:
                  "1- After filling the survey open the icons of each category & record his voice to save"
                  " them in the way he says it in the \"Dictionary\"."),
          TextIn(
              title:
                  "2- you can go to \"Add photo\" and add what the kid likes and record his words so that whenever he wants "
                  " it he can use the microphone to search for it."),
          TextIn(
              title:
                  "3- Check your phone when a message appears from Nedz application, it will inform you"
                  " what the kid wants or feels."),
          TextIn(
              title:
                  "4- You can use the \"Chat\" icon when the kid is in a bad mood, it gives you some suggestions"
                  " for his behaviour."),
          TextIn(
              title:
                  "5- You can check your kid's emotions from the saved data if he had ever chosen an emoji"
                  " from the \"Data\" icon."),
          TextIn(
              title:
                  "6- You can open the \"Dictionary\" and see how the kid refers to the things in his own"
                  " words and also reach to the pictures he adds from \"Add photo\"."),
          TextIn(
              title:
                  "7- You can add as many kids as you want by opening the Drawer and click on Add and repeat the same process."),
          TextIn(
              title:
                  "We recommend using tablets for this application, wider screens are better for the eyes!"),
          SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }
}
