import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class SnackBarUtil {
  static void showSuccessBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: QEColors.success,
      ),
    );
  }

  static void showErrorBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: QEColors.error,
      ),
    );
  }
}
