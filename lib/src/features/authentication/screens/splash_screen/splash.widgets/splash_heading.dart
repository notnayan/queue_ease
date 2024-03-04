import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SplashHeading extends StatelessWidget {
  const SplashHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: -0.25,
        child: Text(
          QETexts.appSlogan,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
