import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class OnboardingNext extends StatelessWidget {
  const OnboardingNext({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      right: QESizes.defaultSpace,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
        onPressed: () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? QEColors.primary : QEColors.black),
        child: const Icon(CupertinoIcons.right_chevron),
      ),
    );
  }
}
