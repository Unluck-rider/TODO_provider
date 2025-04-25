import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  Responsive({required this.mobile, required this.tablet});

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) {
    return isTablet(context) ? tablet : mobile;
  }
}
