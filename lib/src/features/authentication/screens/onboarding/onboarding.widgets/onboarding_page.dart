import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(QESizes.defaultSpace),
      child: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: QEColors.accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image(
              image: AssetImage(image),
            ),
          ),
          const SizedBox(
            height: QESizes.spaceBtwSections,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: QEColors.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: QESizes.spaceBtwItems,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
