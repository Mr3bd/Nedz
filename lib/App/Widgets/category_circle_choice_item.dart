import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Utilities/Constants/AppStyles.dart';

class CategoryCircleChoiceItem extends StatelessWidget {
  final String path;
  final VoidCallback onTap;

  CategoryCircleChoiceItem({required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: path.contains('data/user')
              ? null
              : Border.all(width: 1.0, color: AppColors.grey.withOpacity(0.1)),
          boxShadow:
              path.contains('data/user') ? null : [AppStyles.primaryShadow],
          shape: BoxShape.circle,
          color: path.contains('data/user')
              ? Colors.transparent
              : AppColors.secondary),
      child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: path.contains('data/user')
                  ? Colors.transparent
                  : AppColors.secondary,
              shape: BoxShape.circle,
            ), // LinearGradientBoxDecoration
            child: InkWell(
              onTap: onTap,
              customBorder: CircleBorder(),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                    child: path.contains('data/user')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.file(
                              File(path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : SvgPicture.asset(
                            path,
                            fit: BoxFit.contain,
                          )),
              ),
            ), // Red will correctly spread over gradient
          )),
    );
  }
}
