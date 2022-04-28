import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  final lat, lng;
  const GoogleMaps({Key? key, required this.lat, required this.lng})
      : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(widget.lat, widget.lng),
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
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
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width - 60,
      child: GoogleMap(
        scrollGesturesEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        markers: markers.values.toSet(),
        initialCameraPosition:
            CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 15.5),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
