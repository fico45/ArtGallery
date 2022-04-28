import 'package:artgallery/view/widgets/appbar.dart';
import 'package:artgallery/view/widgets/googlemaps.dart';
import 'package:artgallery/view/widgets/image_view/image.dart';
import 'package:flutter/material.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExhibitDetailsView extends ConsumerStatefulWidget {
  final Exhibit exhibit;
  ExhibitDetailsView({Key? key, required this.exhibit}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExhibitDetailsViewState();
}

class _ExhibitDetailsViewState extends ConsumerState<ExhibitDetailsView> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    final exhibitUser = ref.watch(getUserProvider(widget.exhibit.userId));
    return Hero(
      //TODO: ensure this is correct
      tag: widget.exhibit.id!,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80), child: CustomAppBar()),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.exhibit.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.exhibit.location,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                    Text(
                      ref.watch(userControllerProvider).when(
                          data: (data) => data.firstName + ' ' + data.lastName,
                          error: (error, st) =>
                              'There seems to be an error with loading the data.',
                          loading: () => 'Loading...'),
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: Row(
                        children: [
                          Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: exhibitUser.when(
                                  data: (data) => CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data.image_url),
                                      ),
                                  error: (error, st) =>
                                      Text('There seems to be an error.'),
                                  loading: () =>
                                      const CircularProgressIndicator())),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TODO: owner name here, please
                                exhibitUser.when(
                                  data: (data) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.firstName + ' ' + data.lastName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      Text(widget.exhibit.location)
                                    ],
                                  ),
                                  error: (error, st) =>
                                      Text('There seems to be an error.'),
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                ),

                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "The owner",
                                  style: TextStyle(color: Color(0xffFB6161)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              //TODO: I think images can go in here.
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text("Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.exhibit.description,
                          style: TextStyle(fontWeight: FontWeight.w300),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width - 60,
                          child: GoogleMaps(
                            lat: widget.exhibit.lat,
                            lng: widget.exhibit.lng,
                          ),
                        ),
                        Container(
                          height: 80,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 73,
          child: BottomAppBar(
            color: Colors.white,
            elevation: 0.0,
            child: FittedBox(
              fit: BoxFit.none,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 6.0),
                    height: 46,
                    width: 186,
                    decoration: BoxDecoration(
                      color: Color(0xffFB6161),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Text(
                      "Make an offer",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
