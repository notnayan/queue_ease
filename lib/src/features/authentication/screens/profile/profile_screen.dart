import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:queue_ease/src/features/authentication/screens/profile/profile.widgets/profile_menu.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          children: [
            Stack(
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
            const SizedBox(
              height: QESizes.spaceBtwItems,
            ),
            const SizedBox(
              height: QESizes.spaceBtwItems,
            ),
            //MENU
            ProfileMenu(
              title: QETexts.firstName,
              icon: CupertinoIcons.person,
              onPress: () {},
            ),
            const Divider(),
            ProfileMenu(
              title: QETexts.lastName,
              icon: CupertinoIcons.person,
              onPress: () {},
            ),
            const Divider(),
            ProfileMenu(
              title: QETexts.phoneNm,
              icon: CupertinoIcons.phone,
              onPress: () {},
            ),
            const Divider(),
            ProfileMenu(
              title: QETexts.email,
              icon: CupertinoIcons.mail,
              onPress: () {},
            ),
            const Divider(),
            ProfileMenu(
              title: QETexts.city,
              icon: CupertinoIcons.building_2_fill,
              onPress: () {},
            ),
            const Divider(),
            const Expanded(
              child: SizedBox.expand(),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(QETexts.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
