import 'package:flutter/material.dart';

class DashboardMenuModel {
  final String image, subtitle;
  final VoidCallback onPressed;

  DashboardMenuModel(
      {required this.image, required this.subtitle, required this.onPressed});
}
