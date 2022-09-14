import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Explore extends ConsumerStatefulWidget {
  final Widget openDrawer;
  const Explore({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreState();
}

class _ExploreState extends ConsumerState<Explore> {
  final Set<Marker> markers = new Set();

  //TODO: center the view to the user location
  //Location userCurrentLocation = Location();

  @override
  void initState() {
    super.initState();

    ref
        .read(exhibitListControllerProvider)
        .whenData((value) => value.forEach((element) {
              markers.add(
                Marker(
                  infoWindow: InfoWindow(
                    title: element.title,
                    snippet:
                        "${element.location.street}, ${element.location.city}",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ExhibitDetailsView(exhibit: element)),
                    ),
                  ),
                  markerId: MarkerId(element.id!),
                  position: LatLng(
                    element.lat,
                    element.lng,
                  ),
                ),
              );
            }));
  }

  late GoogleMapController _googleMapController;

  void _onMapCreated(GoogleMapController _controller) async {
    _googleMapController = _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(
          openDrawer: widget.openDrawer,
        ),
      ),
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        scrollGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(45.81313600000001, 15.970835),
          zoom: 8,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  //example of how to go to the location
  //might be useful for "Go to Exhibit xy"
  /*  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  } */
}
