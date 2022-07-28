import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class HelpSingleItem extends StatelessWidget {
  final String path, title;
  HelpSingleItem({required this.path, required this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 16.0, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            path,
            width: width * 0.08,
            height: width * 0.08,
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: Text(
            title,
            style: TextStyle(fontSize: 17, color: AppColors().vdblue),
          ))
        ],
      ),
    );
  }
}
