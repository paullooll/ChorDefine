import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static double padding(BuildContext context) => width(context) * 0.04;
  static double cardPadding(BuildContext context) => width(context) * 0.035;
  static double horizontalPadding(BuildContext context) => width(context) * 0.05;

  static double titleLarge(BuildContext context) => width(context) * 0.09;
  static double titleMedium(BuildContext context) => width(context) * 0.065;
  static double titleSmall(BuildContext context) => width(context) * 0.045;
  static double bodyText(BuildContext context) => width(context) * 0.04;
  static double captionText(BuildContext context) => width(context) * 0.035;

  static double iconSize(BuildContext context) => width(context) * 0.08;
  static double cardHeight(BuildContext context) => height(context) * 0.16;
  static double cardImageSize(BuildContext context) => width(context) * 0.18;

  static double appBarHeight(BuildContext context) => height(context) * 0.15;
  static double bottomNavIconSize(BuildContext context) => width(context) * 0.065;

  static double fontSize(double size, BuildContext context) => width(context) * (size / 375);
}
