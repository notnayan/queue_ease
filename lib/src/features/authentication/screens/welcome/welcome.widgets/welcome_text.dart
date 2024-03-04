import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          QETexts.welcomeTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: QESizes.spaceBtwItems,
        ),
        Text(
          QETexts.welcomeSubtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
