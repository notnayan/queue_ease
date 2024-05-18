import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue_ease/src/features/booking/screens/home/home_screen.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class AgentRegistration extends StatefulWidget {
  final token;
  const AgentRegistration({Key? key, @required this.token}) : super(key: key);

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
                  color: Colors.white,
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
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      //TODO: Document code
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
                ),
                const SizedBox(width: QESizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Your record has been submitted!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          backgroundColor: QEColors.success,
                        ),
                      );
                      Get.to(HomeScreen(
                        token: widget.token,
                      ));
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
