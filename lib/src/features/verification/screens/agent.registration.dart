import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/features/booking/screens/home/home_screen.dart';
import 'package:queue_ease/src/features/common/snackbar.dart';
import 'package:queue_ease/src/utils/constants/image_strings.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

import '../../../utils/http/http_client.dart';

class AgentRegistration extends StatefulWidget {
  final String token;
  const AgentRegistration({Key? key, required this.token}) : super(key: key);

  @override
  State<AgentRegistration> createState() => _AgentRegistrationState();
}

class _AgentRegistrationState extends State<AgentRegistration> {
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
      SnackBarUtil.showErrorBar(
          context, "No image selected. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: ClipOval(
                child: Container(
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    'assets/images/pp.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
                  width: QESizes.spaceBtwItems,
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
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  labelText: email,
                  prefixIcon: const Icon(CupertinoIcons.mail)),
            ),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  labelText: phoneNumber,
                  prefixIcon: const Icon(CupertinoIcons.phone)),
            ),
            Row(
              children: [
                image == null
                    ? Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            //TODO: Document code
                            getImage();
                          },
                          child: const Row(
                            children: [
                              Icon(CupertinoIcons.doc),
                              SizedBox(
                                width: 2,
                              ),
                              Text("DOCUMENT ↑↑"),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            getImage();
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(0.5),
                            side: const BorderSide(color: Colors.green),
                          ),
                          child: const Row(
                            children: [
                              Icon(CupertinoIcons.doc),
                              SizedBox(
                                width: 2,
                              ),
                              Text(" Uploaded ↑↑"),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(width: QESizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final Map<String, dynamic> data = {
                        'firstName': firstName,
                        'lastName': lastName,
                        'email': email,
                        'phoneNumber': phoneNumber
                      };
                      try {
                        final res = await QEHttpHelper.post('agent', data);

                        if (res['status']) {
                          (Hive.box('user').get('user') as Map)
                              .addAll({'isAgent': true});
                        }

                        if (!context.mounted) return;
                        SnackBarUtil.showSuccessBar(
                            context, 'Your record has been submitted!');
                        Get.to(HomeScreen(
                          token: widget.token,
                        ));
                      } catch (e) {
                        SnackBarUtil.showErrorBar(context, e.toString());
                      }
                    },
                    child: const Text("DONE"),
                  ),
                ),
              ],
            ),
            const Text(
              "By tapping <DONE> I agree with Terms and Conditions, I acknowledge and agree with processing and transfer of personal data according to the conditions of Privacy Policy!",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
