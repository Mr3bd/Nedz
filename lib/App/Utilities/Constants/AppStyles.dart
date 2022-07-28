import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static BoxShadow primaryShadow = BoxShadow(
    color: AppColors.black.withOpacity(0.1),
    blurRadius: 5,
    spreadRadius: 0.2,
    offset: const Offset(0, 3),
  );
}
