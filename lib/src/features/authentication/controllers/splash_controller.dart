import 'package:get/get.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding/onboarding_screen.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  Future endSplash() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.to(const OnboardingScreen());
  }
}
