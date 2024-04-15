import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup.widgets/signup_form.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            QESizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        QETexts.signupTitle1,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: QEColors.primary),
                      ),
                      Text(
                        QETexts.signupTitle2,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: QEColors.accent),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: QESizes.spaceBtwItems,
                  ),
                  Image(
                    height: 125,
                    image: AssetImage(
                        dark ? QEImage.lightAppLogo : QEImage.darkAppLogo),
                  ),
                ],
              ),

              const SizedBox(
                height: QESizes.spaceBtwSections,
              ),

              // Form
              const SignupForm()
            ],
          ),
        ),
      ),
    );
  }
}
