import 'package:artgallery/widgets/exhibit/address%20search/address_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'address search/place_service.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';

const kGoogleApiKey = 'AIzaSyBEya3BPIYwvGG84eXz1VEC9hO0ss96cXE';

class NewExhibit extends StatefulWidget {
  static const routeName = '/new-exhibit';

  const NewExhibit({Key? key}) : super(key: key);

  @override
  _NewExhibitState createState() => _NewExhibitState();
}

class _NewExhibitState extends State<NewExhibit> {
  final _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  TextEditingController _place = new TextEditingController();
  var _description = '';
  var _title = '';
  var _location = '';
  var _dateTime = '';

  @override
  void dispose() {
    _place.dispose();
    super.dispose();
  }

  void _postExhibit() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    FirebaseFirestore.instance.collection('exhibits').add({
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
      'description': _description,
      'title': _title,
      'location': _location,
      'dateTime': _dateTime,
      'exhibitImage': '',
    });
    _place.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exhibit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                key: ValueKey('title'),
                decoration: InputDecoration(
                  labelText: 'Title',
                  icon: Icon(Icons.text_fields),
                ),
                onChanged: (value) {
                  _title = value;
                },
              ),
              TextFormField(
                readOnly: true,
                controller: _place,
                key: ValueKey('location'),
                decoration: InputDecoration(
                  labelText: 'Location',
                  icon: Icon(Icons.home),
                ),
                onChanged: (text) {
                  _location = text;
                },
                onTap: () async {
                  Prediction? p = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: kGoogleApiKey,
                      mode: Mode.overlay, // Mode.fullscreen
                      offset: 0,
                      radius: 1000,
                      strictbounds: false,
                      region: "",
                      language: "hr",
                      sessionToken: UniqueKey().toString(),
                      components: [new Component(Component.country, "hr")],
                      types: [""],
                      hint: "Search Address",
                      startText: '');

                  //this should save the selected location and show it in form field
                  _place.text = p!.description.toString();
                  /* final sessionToken = Uuid().v4();
                  final Suggestion result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  ); */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
