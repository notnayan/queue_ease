import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: QESizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.mail),
                  labelText: QETexts.email),
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),

            // Password
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.lock),
                  suffixIcon: Icon(CupertinoIcons.eye),
                  labelText: QETexts.password),
            ),

            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(QETexts.logIn),
              ),
            ),

            const SizedBox(
              height: QESizes.spaceBtwItems,
            ),
          ],
        ),
      ),
    );
  }
}
