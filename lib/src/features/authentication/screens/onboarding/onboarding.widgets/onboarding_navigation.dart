import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/controllers/onboarding_controller.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingNavigation extends StatelessWidget {
  const OnboardingNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: const ExpandingDotsEffect(
          activeDotColor: QEColors.accent,
          dotHeight: 6,
        ),
      ),
    );
  }
}
