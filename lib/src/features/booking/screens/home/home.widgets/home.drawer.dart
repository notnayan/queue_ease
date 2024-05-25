// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/features/booking/screens/home/home_screen.dart';
import 'package:queue_ease/src/features/chat/screens/chat_screen.dart';
import 'package:queue_ease/src/features/common/settings_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:queue_ease/src/features/common/snackbar.dart';
import 'package:queue_ease/src/features/verification/screens/agent.registration.dart';
import 'package:queue_ease/src/features/verification/screens/agent_dashboard.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';
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
                accountName: Hive.box('user').get('user')['isAgent'] == false
                    ? Center(
                        child: Text(
                          firstName + (' (USER)'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    : Center(
                        child: Text(
                          firstName + (' (AGENT)'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                accountEmail: Center(
                  child: Text(
                    email,
                    style: Theme.of(context).textTheme.titleSmall,
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
            if (Hive.box('user').get('user')['isAgent'] == true)
              ListTile(
                onTap: () {
                  Get.to(AgentDashboard(
                    token: widget.token,
                  ));
                },
                leading: const Icon(
                  CupertinoIcons.clock,
                  color: Colors.white,
                ),
                title: const Text(
                  "R E Q U E S T S",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ListTile(
              onTap: () async {
                final res = await QEHttpHelper.post(
                  'request/isAccepted',
                  {"userId": Hive.box('user').get('user')['_id']},
                );
                print(res);
                if (!res['isSearching']) {
                  SnackBarUtil.showErrorBar(context, "No messages yet!");
                  scaffoldKey.currentState?.closeDrawer();
                  return;
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChatPage()));
              },
              leading: const Icon(
                CupertinoIcons.chat_bubble_2,
                color: Colors.white,
              ),
              title: const Text(
                "C H A T S",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            if (Hive.box('user').get('user')['isAgent'] == false)
              Padding(
                padding: const EdgeInsets.all(QESizes.buttonRadius),
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                "AGENT MODE",
                                style: TextStyle(fontSize: 20),
                              ),
                              content: const Text(
                                "Do you want to become an agent?",
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Get.to(AgentRegistration(
                                      token: widget.token,
                                    ));
                                  },
                                  child: const Text(
                                    "YES",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(QESizes.iconMd),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    child: const Text("AGENT MODE")),
              )
          ],
        ),
      ),
    );
  }
}
