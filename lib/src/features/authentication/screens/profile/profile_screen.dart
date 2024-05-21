import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:queue_ease/src/features/common/snackbar.dart';
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
    void logoutUser() async {
      // Clear data stored in the Hive box
      var box = await Hive.openBox('localData');
      await box.clear();

      // Redirect user to the welcome screen
      Get.offAll(const WelcomeScreen());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.all(QESizes.defaultSpace),
        child: Column(
          children: [
            const Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: ClipOval(
                  child: Image(
                      image: AssetImage(QEImage.profileImage),
                      fit: BoxFit.fill),
                ),
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text(
                            "LOG OUT",
                            style: TextStyle(fontSize: 20),
                          ),
                          content: const Text(
                            "Are you sure you want to log out?",
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                logoutUser();
                                SnackBarUtil.showSuccessBar(
                                    context, "Logged Out Successfully!");
                              },
                              child: const Text(
                                "YES",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "NO",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.logout),
                label: const Text("LOG OUT"),
              ),
            ),
            const SizedBox(
              height: QESizes.buttonHeight,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton.icon(
            //     onPressed: () {},
            //     icon: const Icon(CupertinoIcons.trash),
            //     label: const Text("DELETE ACCOUNT"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
