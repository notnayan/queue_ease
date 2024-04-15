import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              QETexts.appName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: QEColors.primary),
            ),
            const SizedBox(
              height: QESizes.spaceBtwItems,
            ),
            Text(
              QETexts.appSlogan,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: QEColors.accent),
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            Text(
              "QueueEase revolutionizes the way you tackle waiting lines. No more wasting time under the scorching sun or in noisy crowds. With QueueEase, you can bid farewell to awful wait times and effortlessly skip queues.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            const Divider(
              color: QEColors.primary,
              thickness: 2,
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            Text(
              "How QueueEase works:",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: QEColors.primary),
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            Text(
              "- Book an agent to stand in line for you",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              "- Receive real-time updates on your queue status",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              "- Save time, reduce stress, and enjoy the convenience of skipping lines",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            Center(
              child: Text(
                "----------------\nJoin us today and wave goodbye to long queues!\n----------------",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: QEColors.accent),
                textAlign: TextAlign.center,
              ),
            ),
          ],
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
