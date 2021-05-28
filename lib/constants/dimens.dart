import 'package:flutter/cupertino.dart';

class Dimens {
  Dimens._();

  //for all screens
  static const double horizontal_padding = 12.0;
  static const double vertical_padding = 12.0;
  static const double topMargin100PX = 100.0;
  static const double logoSize = 124;
  static const double menuIconSize = 24;
  static const double headersTextSize = 18;
  static const double menuRowSpaceDivider = 8;

  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  static double screenWidth(context) => MediaQuery.of(context).size.width;

  static double screenHeight(context) => MediaQuery.of(context).size.height;
}
