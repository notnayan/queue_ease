import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness themeBrightness = Theme.of(context).brightness;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Transform.rotate(
                angle: -0.35,
                child: Text(
                  QETexts.appSlogan,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  themeBrightness == Brightness.dark
                      ? QEImage.lightAppLogo
                      : QEImage.darkAppLogo,
                  height: QESizes.iconLg,
                ),
                Container(
                  height: 50,
                  width: 10,
                  color: themeBrightness == Brightness.dark
                      ? QEColors.white
                      : QEColors.black,
                ),
                Text(
                  QETexts.appName,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
