import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup.widgets/signup_form.dart';
import 'package:queue_ease/src/features/common/snackbar.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            QESizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              // Title
              Center( 
                child: Column(
                  children: [
                    Text(
                      QETexts.signupTitle1,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: QEColors.primary),
                    ),
                    Text(
                      QETexts.signupTitle2,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: QEColors.accent),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: QESizes.spaceBtwSections*3,
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
