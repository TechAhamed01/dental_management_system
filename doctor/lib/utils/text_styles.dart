import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.heading,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: AppColors.subtitle,
  );

  static const TextStyle button = TextStyle(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}