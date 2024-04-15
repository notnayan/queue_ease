import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeGoogleMaps extends StatefulWidget {
  const HomeGoogleMaps({Key? key}) : super(key: key);

  @override
  State<HomeGoogleMaps> createState() => _HomeGoogleMapsState();
}

class _HomeGoogleMapsState extends State<HomeGoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.679228, 85.328519),
    zoom: 14,
  );

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      infoWindow: InfoWindow(title: "Current Postion"),
      markerId: MarkerId('1'),
      position: LatLng(27.679228, 85.328519),
    ),
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
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set<Marker>.of(_marker),
      myLocationEnabled: true,
    );
  }
}
