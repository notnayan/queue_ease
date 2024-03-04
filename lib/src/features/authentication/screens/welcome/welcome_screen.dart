import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/welcome/welcome.widgets/welcome_button.dart';
import 'package:queue_ease/src/features/authentication/screens/welcome/welcome.widgets/welcome_text.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(QESizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                dark ? QEImage.lightAppLogo : QEImage.darkAppLogo,
              ),
              const WelcomeText(),
              const WelcomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
