import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding_screen/widgets/onboarding_navigation.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding_screen/widgets/onboarding_next.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding_screen/widgets/onboarding_page.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding_screen/widgets/onboarding_skip.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: const [
              OnboardingPage(
                  image: QEImage.onboardingScreen1,
                  title: QETexts.onBoardingTitle1,
                  subtitle: QETexts.onBoardingSubTitle1),
              OnboardingPage(
                  image: QEImage.onboardingScreen2,
                  title: QETexts.onBoardingTitle2,
                  subtitle: QETexts.onBoardingSubTitle2),
              OnboardingPage(
                  image: QEImage.onboardingScreen3,
                  title: QETexts.onBoardingTitle3,
                  subtitle: QETexts.onBoardingSubTitle3),
            ],
          ),
          OnboardingNavigation(
            pageController: pageController,
          ),
          OnboardingSkip(
            pageController: pageController,
          ),
          OnboardingNext(
            pageController: pageController,
          )
        ],
      ),
    );
  }
}
