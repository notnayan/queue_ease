import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(QESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit your Password",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: QEColors.primary),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "Set up your account with a strong password!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: QESizes.spaceBtwSections,
              ),
              Text(
                "Your password must:",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: QEColors.accent),
              ),
              const SizedBox(height: QESizes.spaceBtwItems),
              Text(
                "1. Use a minimum of 8 characters.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: QESizes.spaceBtwItems),
              Text(
                "2. Use combination of uppercase and lowercase letters, numbers, and symbols.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: QESizes.spaceBtwSections,
              ),
              Text(
                "Current Password:",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: QEColors.accent),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.lock),
                    suffixIcon: Icon(CupertinoIcons.eye),
                    labelText: QETexts.password),
                obscureText: true,
              ),
              const SizedBox(
                height: QESizes.spaceBtwSections,
              ),
              Text(
                "New Password:",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: QEColors.accent),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.lock),
                    suffixIcon: Icon(CupertinoIcons.eye),
                    labelText: "New Password"),
                obscureText: true,
              ),
              const SizedBox(
                height: QESizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
