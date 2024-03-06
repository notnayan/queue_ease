import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/controllers/onboarding_controller.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingNavigation extends StatelessWidget {
  const OnboardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      bottom: kBottomNavigationBarHeight + 25,
      left: QESizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? QEColors.light : QEColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
