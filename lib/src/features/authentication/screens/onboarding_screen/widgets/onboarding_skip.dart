import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kToolbarHeight,
      right: QESizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          pageController.animateToPage(
            pageController.page!.toInt() + 2,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: Text(
          "SKIP",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
