import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class ProfileScreen extends StatefulWidget {
  final token;
  const ProfileScreen({super.key, @required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String firstName;
  late String lastName;
  late String email;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    firstName = jwtDecodedToken['firstName'];
    lastName = jwtDecodedToken['lastName'];
    phoneNumber = jwtDecodedToken['phoneNumber'];
  }

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
                        image: NetworkImage(QEImage.profileImage),
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
                    decoration: InputDecoration(
                        labelText: firstName,
                        prefixIcon: const Icon(CupertinoIcons.person)),
                  ),
                ),
                const SizedBox(
                  width: QESizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    expands: false,
                    decoration: InputDecoration(
                        labelText: lastName,
                        prefixIcon: const Icon(CupertinoIcons.person)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  labelText: email,
                  prefixIcon: const Icon(CupertinoIcons.mail)),
            ),
            const SizedBox(
              height: QESizes.spaceBtwSections,
            ),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  labelText: phoneNumber,
                  prefixIcon: const Icon(CupertinoIcons.phone)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.trash),
                label: const Text("DELETE ACCOUNT"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
