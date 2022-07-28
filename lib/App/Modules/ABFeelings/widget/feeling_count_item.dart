import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class FeelingCountItem extends StatelessWidget {
  final String path;
  double percentage;
  FeelingCountItem({required this.path, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: (Get.width * 0.1),
          height: percentage < 0 ? 0 : (Get.width * 0.5) * (percentage),
          color: AppColors.primary,
        ),
        SizedBox(
          height: 16.0,
        ),
        SvgPicture.asset(
          path,
          width: Get.width * 0.05,
          height: Get.width * 0.05,
        )
      ],
    ).marginSymmetric(horizontal: 8.0);
  }
}
