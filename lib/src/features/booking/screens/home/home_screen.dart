import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.drawer.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.googlemaps.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home_dropdownbox.dart';
import 'package:queue_ease/src/features/chat/screens/chat_screen.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({Key? key, @required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentAddress = '';
  late String email;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  Future<void> _getCurrentLocation() async {
    try {
      var status = await Permission.location.status;
      if (!status.isGranted) {
        status = await Permission.location.request();
        if (status.isDenied) {
          print('Location permission was denied.');
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.subLocality}, ${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QETexts.appName),
        elevation: 0,
      ),
      drawer: MyDrawer(token: widget.token),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 1.95,
              child: const HomeGoogleMaps(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                  color: QEColors.primary,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(8, QESizes.defaultSpace, 8, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(CupertinoIcons.location_solid),
                          const SizedBox(width: QESizes.xs),
                          Expanded(
                            child: Text(
                              _currentAddress.isNotEmpty
                                  ? _currentAddress
                                  : "Fetching location...",
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: QESizes.spaceBtwSections),
                      const HomeDropDownMenu(),
                      const SizedBox(height: QESizes.spaceBtwInputFields),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: QETexts.fare,
                          prefixIcon: Icon(CupertinoIcons.money_dollar),
                        ),
                        enabled: false,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: QEColors.accent,
                                ),
                                onPressed: () {
                                  Get.to(ChatPage(
                                    token: widget.token,
                                  ));
                                },
                                child: Text(
                                  "Find an Agent",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
