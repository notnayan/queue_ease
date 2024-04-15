import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/verification/screens/agent_dashboard.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class AgentRegistration extends StatelessWidget {
  const AgentRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: QESizes.spaceBtwItems,
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Add A Photo"),
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: QETexts.firstName,
                      prefixIcon: Icon(CupertinoIcons.person),
                    ),
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
                      prefixIcon: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: QETexts.email,
                prefixIcon: Icon(CupertinoIcons.mail),
              ),
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: QETexts.phoneNm,
                prefixIcon: Icon(CupertinoIcons.phone),
              ),
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Column(
                      children: [
                        Text("Upload Document"),
                        SizedBox(
                          height: 8,
                        ),
                        Icon(CupertinoIcons.doc),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: QESizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Column(
                      children: [
                        Text("Upload Description"),
                        SizedBox(
                          height: 8,
                        ),
                        Icon(CupertinoIcons.text_bubble),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const AgentDashboard());
                },
                child: const Text("DONE"),
              ),
            ),
            const SizedBox(
              height: QESizes.spaceBtwInputFields,
            ),
            const Text(
              "By tapping <<Done>> I agree with Terms and Conditions, I acknowledge and agree with processing and transfer of personal data according to the conditions of Privacy Policy.",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
