import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/onboarding_screen/onboarding_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/splash_screen/widgets/splash_bottom.dart';
import 'package:queue_ease/src/features/authentication/screens/splash_screen/widgets/splash_heading.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });

    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          children: [
            Spacer(),
            SplashHeading(),
            Spacer(),
            SplashBottom()
          ],
        ),
      ),
    );
  }
}
