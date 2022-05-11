import 'dart:io';

import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMaps extends StatefulWidget {
  final Exhibit exhibit;
  const GoogleMaps({Key? key, required this.exhibit}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static Future<void> openMap(double latitude, double longitude) async {
    String appleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (Platform.isIOS) {
      print('Map success, Apple');
      await launchUrl(Uri.parse(appleMapUrl));
    } else if (Platform.isAndroid) {
      print('Map success, Android');
      await launchUrl(Uri.parse('geo:$latitude,$longitude'));
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(widget.exhibit.lat, widget.exhibit.lng),
      infoWindow: InfoWindow(
        title: widget.exhibit.location.street,
        snippet: widget.exhibit.location.city,
      ),
    );
    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openMap(widget.exhibit.lat, widget.exhibit.lng),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width - 60,
        child: GoogleMap(
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
          markers: markers.values.toSet(),
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.exhibit.lat, widget.exhibit.lng),
              zoom: 15.5),
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
