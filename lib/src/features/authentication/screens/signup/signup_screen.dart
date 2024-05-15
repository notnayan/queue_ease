import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup.widgets/signup_form.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? image; 
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            QESizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        QETexts.signupTitle1,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: QEColors.primary),
                      ),
                      Text(
                        QETexts.signupTitle2,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: QEColors.accent),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: QESizes.spaceBtwItems ,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: 135,
                        height: 135,
                        child: ClipOval(
                          child: Container(
                            child: image == null
                                ? const Image(
                                    image: NetworkImage(QEImage.profileImage),
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    File(image!.path).absolute,
                                    fit: BoxFit.fill,
                                  ),
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
                            onPressed: () {
                              getImage();
                            },
                            icon: const Icon(CupertinoIcons.pencil_outline),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: QESizes.spaceBtwSections,
              ),

              // Form
              const SignupForm()
            ],
          ),
        ),
      ),
    );
  }
}
