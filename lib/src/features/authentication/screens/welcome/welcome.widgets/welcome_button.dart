import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/authentication/screens/login/login_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Get.to(const LoginScreen());
            },
            child: const Text("LOGIN"),
          ),
        ),
        const SizedBox(
          width: QESizes.spaceBtwItems,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.to(const SignupScreen());
            },
            child: const Text("SIGNUP"),
          ),
        )
      ],
    );
  }
}
