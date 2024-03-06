import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SplashBottom extends StatelessWidget {
  const SplashBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          dark ? QEImage.lightAppLogo : QEImage.darkAppLogo,
          height: 75,
        ),
        Container(
          height: 75,
          width: 10,
          color: dark ? QEColors.white : QEColors.black,
        ),
        Text(
          QETexts.appName,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
