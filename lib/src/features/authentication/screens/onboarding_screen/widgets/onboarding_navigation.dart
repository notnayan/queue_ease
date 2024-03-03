import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingNavigation extends StatelessWidget {
  const OnboardingNavigation({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      bottom: kBottomNavigationBarHeight + 25,
      left: QESizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: pageController,
        count: 3,
        onDotClicked: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(
                milliseconds: 500), // Adjust the duration as needed
            curve: Curves.easeInOut,
          );
        },
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? QEColors.light : QEColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
