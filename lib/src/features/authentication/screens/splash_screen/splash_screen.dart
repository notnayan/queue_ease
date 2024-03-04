import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/authentication/controllers/splash_controller.dart';
import 'package:queue_ease/src/features/authentication/screens/splash_screen/splash.widgets/splash_bottom.dart';
import 'package:queue_ease/src/features/authentication/screens/splash_screen/splash.widgets/splash_heading.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    splashController.endSplash();

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
