import 'package:get/get.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding_screen/onboarding_screen.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  Future endSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.to(const OnboardingScreen());
  }
}
