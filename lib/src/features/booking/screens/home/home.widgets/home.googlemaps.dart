import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeGoogleMaps extends StatefulWidget {
  const HomeGoogleMaps({Key? key}) : super(key: key);

  @override
  State<HomeGoogleMaps> createState() => _HomeGoogleMapsState();
}

class _HomeGoogleMapsState extends State<HomeGoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _initialCameraPosition;
  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      infoWindow: InfoWindow(title: "Chabahil"),
      markerId: MarkerId('2'),
      position: LatLng(27.712121121054984, 85.36036444543224),
    ),
    Marker(
      infoWindow: InfoWindow(title: "Ekantakuna"),
      markerId: MarkerId('3'),
      position: LatLng(27.66603027396045, 85.31286686756212),
    ),
    Marker(
      infoWindow: InfoWindow(title: "Radhe Radhe"),
      markerId: MarkerId('4'),
      position: LatLng(27.678030177997023, 85.39914315222262),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
      );
      setState(() {
        _marker.add(
          Marker(
            markerId: const MarkerId('1'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: "Current Position"),
          ),
        );
        _marker.addAll(_list);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialCameraPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: _initialCameraPosition!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(_marker),
              myLocationEnabled: true,
            ),
    );
  }
}

