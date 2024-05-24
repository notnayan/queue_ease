import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:queue_ease/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:queue_ease/src/features/common/about_screen.dart';
import 'package:queue_ease/src/features/common/change_password_screen.dart';
import 'package:queue_ease/src/features/common/help_screen.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SettingsScreen extends StatefulWidget {
  final token;
  const SettingsScreen({super.key, @required this.token});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QETexts.settings),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Text(
                    "General",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: QEColors.accent),
                  ),
                ],
              ),

              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              //Item1
              InkWell(
                onTap: () => Get.to(ProfileScreen(token: widget.token)),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: QEColors.primary,
                      ),
                      child: const Icon(
                        CupertinoIcons.person,
                        color: QEColors.white,
                      ),
                    ),
                    const SizedBox(
                      width: QESizes.spaceBtwItems,
                    ),
                    Text(
                      "Profile",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.chevron_forward,
                      color: QEColors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              //ITEM2
              // InkWell(
              //   onTap: () => Get.to(const ChangePasswordScreen()),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: QEColors.primary,
              //         ),
              //         child: const Icon(
              //           CupertinoIcons.lock,
              //           color: QEColors.white,
              //         ),
              //       ),
              //       const SizedBox(
              //         width: QESizes.spaceBtwItems,
              //       ),
              //       Text(
              //         "Change Password",
              //         style: Theme.of(context).textTheme.titleLarge,
              //       ),
              //       const Spacer(),
              //       const Icon(
              //         CupertinoIcons.chevron_forward,
              //         color: QEColors.white,
              //       ),
              //     ],
              //   ),
              // ),

              // const SizedBox(
              //   height: QESizes.spaceBtwSections,
              // ),

              // //TITLE
              // Row(
              //   children: [
              //     Text(
              //       "App",
              //       style: Theme.of(context)
              //           .textTheme
              //           .headlineMedium
              //           ?.copyWith(color: QEColors.accent),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: QESizes.spaceBtwItems,
              // ),

              //ITEM1
              InkWell(
                onTap: () => Get.to(const HelpScreen()),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: QEColors.primary,
                      ),
                      child: const Icon(
                        CupertinoIcons.question_circle,
                        color: QEColors.white,
                      ),
                    ),
                    const SizedBox(
                      width: QESizes.spaceBtwItems,
                    ),
                    Text(
                      "Help",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.chevron_forward,
                      color: QEColors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: QESizes.spaceBtwItems,
              ),

              // ITEM2
              InkWell(
                onTap: () => Get.to(const AboutScreen()),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: QEColors.primary,
                      ),
                      child: const Icon(
                        CupertinoIcons.star,
                        color: QEColors.white,
                      ),
                    ),
                    const SizedBox(
                      width: QESizes.spaceBtwItems,
                    ),
                    Text(
                      "About Us",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.chevron_forward,
                      color: QEColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
