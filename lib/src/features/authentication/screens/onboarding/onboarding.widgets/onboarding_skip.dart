import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/controllers/onboarding_controller.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: kBottomNavigationBarHeight + 25,
      left: QESizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: Text(
          "SKIP",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: QEColors.primary),
        ),
      ),
    );
  }
}
