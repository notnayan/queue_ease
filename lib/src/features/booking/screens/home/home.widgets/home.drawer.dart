import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/features/common/settings_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:queue_ease/src/features/verification/screens/agent.registration.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  final token;
  const MyDrawer({super.key, @required this.token});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late String email;
  late String token;
  late String firstName;
  bool isAgent = false;

  Future<void> makePhoneCall(String phoneQE) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneQE);
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    firstName = jwtDecodedToken['firstName'];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: QEColors.dark,
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                margin: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  color: QEColors.primary,
                ),
                accountName: Text(
                  firstName,
                ),
                accountEmail: Text(
                  email,
                ),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: QEColors.accent, width: 2),
                  ),
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(QEImage.profileImage),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            // LISTTILES
            ListTile(
              onTap: () {
                Get.to(ProfileScreen(token: widget.token));
              },
              leading: const Icon(
                CupertinoIcons.person_fill,
                color: Colors.white,
              ),
              title: const Text(
                "P R O F I L E",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(SettingsScreen(
                  token: widget.token,
                ));
              },
              leading: const Icon(
                CupertinoIcons.settings,
                color: Colors.white,
              ),
              title: const Text(
                "S E T T I N G S",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                makePhoneCall("9812345678");
              },
              leading: const Icon(
                CupertinoIcons.phone,
                color: Colors.white,
              ),
              title: const Text(
                "S U P P O R T",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          "AGENT MODE",
                          style: TextStyle(fontSize: 20),
                        ),
                        content: const Text(
                          "Are you sure you want to switch?",
                          style: TextStyle(fontSize: 16),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Get.to(const AgentRegistration());
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
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                "AGENT MODE",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
