import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup.widgets/signup_TOC.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // FirstName LastName
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: QETexts.firstName,
                      prefixIcon: Icon(CupertinoIcons.person)),
                ),
              ),
              const SizedBox(
                width: QESizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: QETexts.lastName,
                      prefixIcon: Icon(CupertinoIcons.person)),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: QESizes.spaceBtwInputFields,
          ),

          // Email
          TextFormField(
            decoration: const InputDecoration(
                labelText: QETexts.email,
                prefixIcon: Icon(CupertinoIcons.mail)),
          ),

          const SizedBox(
            height: QESizes.spaceBtwInputFields,
          ),

          // Password
          TextFormField(
            decoration: const InputDecoration(
              labelText: QETexts.password,
              prefixIcon: Icon(CupertinoIcons.lock),
              suffixIcon: Icon(CupertinoIcons.eye),
            ),
          ),

          const SizedBox(
            height: QESizes.spaceBtwInputFields,
          ),

          // PhoneNumber
          TextFormField(
            decoration: const InputDecoration(
                labelText: QETexts.phoneNm,
                prefixIcon: Icon(CupertinoIcons.phone)),
          ),

          const SizedBox(
            height: QESizes.spaceBtwSections,
          ),

          const SignupTOC(),

          const SizedBox(
            height: QESizes.spaceBtwSections,
          ),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {}, child: const Text(QETexts.createAccount)),
          )
        ],
      ),
    );
  }
}
