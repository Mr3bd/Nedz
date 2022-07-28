import 'package:flutter/material.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class TextIn extends StatelessWidget {
  final String title;
  TextIn({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, top: 16.0, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
