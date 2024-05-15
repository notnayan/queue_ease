import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/splash/splash.widgets/splash_bottom.dart';
import 'package:queue_ease/src/features/authentication/screens/splash/splash.widgets/splash_heading.dart';
import 'package:queue_ease/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:queue_ease/src/features/booking/screens/home/home_screen.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    var ubox = Hive.box('userData');
    bool isFirsttime = ubox.get("isFirstTime");
    var box = await Hive.openBox('localData');
    String? accessToken = box.get("token");

    Widget nextScreen;
    if (isFirsttime) {
      nextScreen = const OnboardingScreen();
    } else {
      if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
        nextScreen = HomeScreen(token: accessToken);
      } else {
        nextScreen = const WelcomeScreen();
      }
    }
    Get.offAll(nextScreen);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          children: [
            Spacer(),
            SplashHeading(),
            Spacer(),
            SplashBottom(),
          ],
        ),
      ),
    );
  }
}
