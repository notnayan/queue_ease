import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:queue_ease/src/features/authentication/controllers/onboarding_controller.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding/onboarding.widgets/onboarding_navigation.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding/onboarding.widgets/onboarding_next.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding/onboarding.widgets/onboarding_page.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding/onboarding.widgets/onboarding_skip.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    var box = Hive.box('userData');
    box.put("isFirstTime", false);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
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
          const OnboardingNavigation(),
          const OnboardingSkip(),
          const OnboardingNext()
        ],
      ),
    );
  }
}
