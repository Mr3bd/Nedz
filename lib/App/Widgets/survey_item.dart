import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class SurveyItem extends StatelessWidget {
  final String path;
  final bool selected;
  final VoidCallback onTap;

  SurveyItem({required this.path, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border:
                Border.all(width: 1.0, color: AppColors.grey.withOpacity(0.3)),
            shape: BoxShape.circle,
            color: selected
                ? AppColors.primary.withOpacity(0.2)
                : AppColors.primaryBackground),
        child: SvgPicture.asset(path),
      ),
    );
  }
}
