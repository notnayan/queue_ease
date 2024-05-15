import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SignupTOC extends StatefulWidget {
  const SignupTOC({
    super.key,
  });

  @override
  State<SignupTOC> createState() => _SignupTOCState();
}

class _SignupTOCState extends State<SignupTOC> {
  bool isChecked = false;
  final Uri urlPP = Uri.parse('https://policies.google.com/privacy?hl=en-US');
  final Uri urlTOU = Uri.parse('https://policies.google.com/terms?hl=en-US');

  Future<void> launchPPUrl() async {
    if (!await launchUrl(urlPP)) {
      throw Exception('Could not launch $urlPP');
    }
  }

  Future<void> launchTOUUrl() async {
    if (!await launchUrl(urlTOU)) {
      throw Exception('Could not launch $urlTOU');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
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
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchPPUrl();
                  },
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
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchTOUUrl();
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
