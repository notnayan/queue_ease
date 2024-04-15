import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  const SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(QEImage.profileImage),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: QEColors.primary),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.pencil_outline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: QESizes.spaceBtwItems * 4,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: false,
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
                    enabled: false,
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: QETexts.lastName,
                        prefixIcon: Icon(CupertinoIcons.person)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            TextFormField(
              enabled: false,
              decoration: const InputDecoration(
                  labelText: QETexts.email,
                  prefixIcon: Icon(CupertinoIcons.mail)),
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            TextFormField(
              enabled: false,
              decoration: const InputDecoration(
                  labelText: QETexts.phoneNm,
                  prefixIcon: Icon(CupertinoIcons.phone)),
            ),
          ],
        ),
      ),
    );
  }
}
