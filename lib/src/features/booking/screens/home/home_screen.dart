import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.drawer.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home.googlemaps.dart';
import 'package:queue_ease/src/features/booking/screens/home/home.widgets/home_dropdownbox.dart';
import 'package:queue_ease/src/features/chat/screens/chat_screen.dart';
import 'package:queue_ease/src/features/common/snackbar.dart';
import 'package:queue_ease/src/features/verification/screens/agent_dashboard.dart';
import 'package:queue_ease/src/services/socket_service.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';
import 'package:queue_ease/src/data/location.dart' as l;

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({Key? key, @required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentAddress = '';
  late String email;

  l.Location? _selectedVal = l.location[0];
  bool isLoading = true;

  late bool isSearching;

  void getIsSearching() async {
    final res = await QEHttpHelper.post(
      'request/isSearching',
      {"userId": Hive.box('user').get('user')['_id']},
    );
    isSearching = res['isSearching'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getIsSearching();
    _getCurrentLocation();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    SocketService().initialize();

    SocketService.newRequestStream.listen((event) {
      if(Hive.box('user').get('user')['isAgent'] == false) return;
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('New Request Received!'),
              content: Text(
                'Name: ${event.requester.firstName} ${event.requester.lastName}\n'
                'Destination: ${event.destination}\n'
                'Price: Rs ${event.price}',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('VIEW'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(AgentDashboard(token: widget.token));
                  },
                ),
                TextButton(
                  child: const Text('CLOSE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });

    SocketService().listen('requestAccepted', (request) {
      print(request);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatPage(
                    receiverId: request['acceptedBy']['_id'],
                    name: request['acceptedBy']['firstName'] + ' ' + request['acceptedBy']['lastName'],
                    phoneNumber: request['acceptedBy']['phoneNumber'],
                    requestId: request['_id'],
                  )));
    });
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
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.name}, ${place.subLocality}, ${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Hive.box('user').get('user'));
    return Scaffold(
      key: scaffoldKey,
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
                  padding: const EdgeInsets.fromLTRB(8, QESizes.defaultSpace, 8, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(CupertinoIcons.location_solid),
                          const SizedBox(width: QESizes.xs),
                          Expanded(
                            child: Text(
                              _currentAddress.isNotEmpty ? _currentAddress : "Fetching location...",
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: QESizes.spaceBtwSections),
                      HomeDropDownMenu(onChanged: (val) => _selectedVal = val),
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
                                  if (isSearching) {
                                    try {
                                      QEHttpHelper.post('request/cancel', {
                                        "userId": Hive.box('user').get('user')['_id'],
                                      });
                                      SnackBarUtil.showSuccessBar(context, "Your search has been cancelled!");
                                      setState(() {
                                        isSearching = false;
                                      });
                                    } catch (e) {
                                      SnackBarUtil.showErrorBar(context, "An error occured while cancelling your search");
                                    }
                                    return;
                                  }
                                  try {
                                    QEHttpHelper.post('request', {
                                      "requesterId": Hive.box('user').get('user')['_id'],
                                      "destination": _selectedVal?.destination,
                                      "price": _selectedVal?.price
                                    });

                                    SnackBarUtil.showSuccessBar(context, "Your booking request has been sent!");
                                    setState(() {
                                      isSearching = true;
                                    });
                                  } catch (e) {
                                    SnackBarUtil.showErrorBar(context, "An error occured while sending your request");
                                  }
                                },
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Text(
                                        isSearching ? "Cancel Search" : "Find an Agent",
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
