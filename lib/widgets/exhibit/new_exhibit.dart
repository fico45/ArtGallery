import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();

  var _description = '';
  var _title = '';
  var _location = '';
  var _startDate = '';
  var _endDate = '';
  var _openingTime = '';
  File? _image;

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

    final ref = FirebaseStorage.instance
        .ref()
        .child('exhibit_images')
        .child(currentUser.uid + '-' + Timestamp.now().toString() + '.jpg');
    await ref.putFile(File(_image!.path));
    final _url = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection('exhibits').add({
      'createdAt': DateTime.now(),
      'userId': currentUser.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
      'description': _description,
      'title': _title,
      'location': _place.text,
      'startDate': _startDate,
      'endDate': _endDate,
      'openingTime': _openingTime,
      'exhibitImage': _url,
    });
    _place.clear();
    Navigator.of(context).pop();
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  key: ValueKey('title'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Title',
                    icon: Icon(Icons.text_fields),
                  ),
                  onChanged: (value) {
                    _title = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  readOnly: true,
                  controller: _place,
                  key: ValueKey('location'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
              ),
              SizedBox(height: 10),
              //Start and end date row
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      onChanged: (val) => _startDate = val,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.calendar_today_outlined),
                        hintText: 'Start date',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      onChanged: (val) => _endDate = val,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.calendar_today_outlined),
                        hintText: 'End date',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: DateTimePicker(
                  type: DateTimePickerType.time,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onChanged: (val) => _openingTime = val,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.timer),
                      hintText: 'Opening time'),
                ),
              ),
              SizedBox(height: 10),
              //Description row
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: TextFormField(
                  key: ValueKey('description'),
                  maxLines: 4,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Description',
                    icon: Icon(Icons.text_fields),
                  ),
                  onChanged: (value) {
                    _description = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(image!.path);
                  });
                },
                child: Text('Upload image'),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.red[200],
                          borderRadius: BorderRadius.circular(32),
                        ),
                        width: 300,
                        height: 300,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: _postExhibit, child: Text('Post exhibit')),
            ],
          ),
        ),
      ),
    );
  }
}
