import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SignupTOC extends StatelessWidget {
  const SignupTOC({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(
          width: QESizes.spaceBtwItems,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${QETexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: '${QETexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? QEColors.white : QEColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? QEColors.white : QEColors.primary,
                    ),
              ),
              TextSpan(
                  text: '${QETexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: '${QETexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? QEColors.white : QEColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? QEColors.white : QEColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
