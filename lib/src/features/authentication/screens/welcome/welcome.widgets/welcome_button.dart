import 'package:flutter/material.dart';
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
            onPressed: () {},
            child: const Text("LOGIN"),
          ),
        ),
        const SizedBox(
          width: QESizes.spaceBtwItems,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("SIGNUP"),
          ),
        )
      ],
    );
  }
}