import 'package:flutter/material.dart';

class QESizes {
  // Padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // Font sizes
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  // Button sizes
  static const double buttonHeight = 18.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;

  // AppBar height
  static const double appBarHeight = 56.0;

  // Custom Size
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: QESizes.appBarHeight,
    bottom: QESizes.defaultSpace,
    left: QESizes.defaultSpace,
    right: QESizes.defaultSpace,
  );

  // Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;

  // Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;

  // Divider height
  static const double dividerHeight = 1.0;

  // Input field
  static const double inputFieldRadius = 12.0;
  static const double spaceBtwInputFields = 16.0;

  // Loading indicator size
  static const double loadingIndicatorSize = 36.0;
}
