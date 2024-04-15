import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(QESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              Text(
                "Information",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: QEColors.primary),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "This is a work in progress application. We intend to add new features so come join the BETA team.",
                style: Theme.of(context).textTheme.bodyMedium
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              const Divider(
                color: QEColors.primary,
                thickness: 2,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              //2
              Text(
                "Feedback",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: QEColors.primary),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "Your feedback is immensely valuable for us to make this application successful. This app is for the community so a small tip can go a long way.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              const Divider(
                color: QEColors.primary,
                thickness: 2,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              //3
              Text(
                "Bugs & Glitches",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: QEColors.primary),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "We’re extremely sorry in advance in case of any trouble. Please contact us and we’ll resolve it asap.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              const Divider(
                color: QEColors.primary,
                thickness: 2,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              //4
              Text(
                "Contact",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: QEColors.primary),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "For assistance please contact us during business hours!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "Email: queueeasesupport@gmail.com",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Text(
                "Phone: +977 9812345678",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              const Divider(
                color: QEColors.primary,
                thickness: 2,
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              Text(
                "Links",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: QEColors.primary),
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Column(
                children: [
                  Text(
                    "Please make sure to give us a follow on the accounts provided below :)",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.facebook,
                      color: QEColors.primary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.github,
                      color: QEColors.primary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.instagram,
                      color: QEColors.primary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.linkedin,
                      color: QEColors.primary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.twitter,
                      color: QEColors.primary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight - 30,
        decoration: const BoxDecoration(color: QEColors.primary),
        child: const Center(
          child: Text("Version 0.0.1"),
        ),
      ),
    );
  }
}
