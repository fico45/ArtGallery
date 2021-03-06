import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/data/functions.dart';
import 'package:artgallery/data/model/address_model/address_data_model.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class NewExhibit extends ConsumerStatefulWidget {
  static const routeName = '/new-exhibit';
  final Exhibit? exhibit;

  NewExhibit({
    Key? key,
    this.exhibit,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewExhibitState();
}

class _NewExhibitState extends ConsumerState<NewExhibit> {
  final GlobalKey<FormState> _newExhibitForm = GlobalKey<FormState>();
  bool isLoading = false;
  final _places = GoogleMapsPlaces(apiKey: dotenv.env['google-api-key']!);
  final EdgeInsets padding =
      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0);

  TextEditingController _place = new TextEditingController();

  void loadInitialData(Exhibit? exhibit) {
    if (exhibit != null) {
      _description = widget.exhibit!.description;
      _title = widget.exhibit!.title;
      _startDateTime = widget.exhibit!.startDateTime;
      _endDate = widget.exhibit!.endDate;
      _openingTime = DateFormat("HH:mm").format(widget.exhibit!.startDateTime);
      _place.text =
          "${widget.exhibit!.location.street}, ${widget.exhibit!.location.city}, ${widget.exhibit!.location.country}";
      _images = widget.exhibit!.imageList.toList();
      _createdAt = widget.exhibit!.createdAt;
      _id = widget.exhibit!.id;
      lat = widget.exhibit!.lat;
      lng = widget.exhibit!.lng;
    }
    ;
  }

  final ImagePicker _picker = ImagePicker();
  Prediction? p;
  late String _description;
  late String _title;
  late String _openingTime;
  late DateTime? _createdAt;
  late String? _id;
  DateTime? _startDateTime;
  DateTime? _endDate;

  late double lat;
  late double lng;
  List<String> _unsubmittedImages = [];
  List<String> _imagesForDeletion = [];

  List<String> _images = [];

  Future<void> getLatLng(Prediction? p) async {
    if (p != null) {
      //get detail lat/lng
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      lat = detail.result.geometry!.location.lat;
      lng = detail.result.geometry!.location.lng;
    }
    print("$lat \n$lng");
  }

  Future<void> _postExhibit(BuildContext context, User currentUser) async {
    bool isValid = _newExhibitForm.currentState!.validate();
    if (!isValid) return;
    setState(() {
      isLoading = true;
    });
    _newExhibitForm.currentState!.save();

    //get the user info
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (_imagesForDeletion.isNotEmpty)
      deleteExhibitImages(currentUser, _imagesForDeletion);

    await getLatLng(p);
    //let's create the AddressData object
    final locationSplit = _place.text.split(',');
    final _address = AddressData(
        street: locationSplit[0],
        city: locationSplit[1],
        country: locationSplit[2]);

    //lastly, exhibit data is uploaded to Firebase
    widget.exhibit == null
        ? ref.read(exhibitListControllerProvider.notifier).addExhibit(
              lat: lat,
              lng: lng,
              createdAt: DateTime.now(),
              description: _description,
              startDateTime: _startDateTime!.add(
                Duration(
                    hours: int.parse(
                      _openingTime[0] + _openingTime[1],
                    ),
                    minutes: int.parse(
                      _openingTime[3] + _openingTime[4],
                    )),
              ),
              endDate: _endDate!,
              location: _address,
              title: _title,
              userId: currentUser.uid,
              imageList: _images,
              username: userData['username'],
            )
        : ref.read(exhibitListControllerProvider.notifier).updateExhibit(
              updatedExhibit: Exhibit(
                id: _id,
                lat: lat,
                lng: lng,
                createdAt: _createdAt!,
                description: _description,
                startDateTime: _startDateTime!,
                endDate: _endDate!,
                imageList: _images,
                location: _address,
                title: _title,
                userId: currentUser.uid,
                username: userData['username'],
              ),
            );
    _place.clear();
    _unsubmittedImages.clear();
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context, _unsubmittedImages);
  }

  @override
  void initState() {
    super.initState();
    loadInitialData(widget.exhibit);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.read(authControllerProvider);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45), child: CustomAppBar()),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, _unsubmittedImages);
          return Future<bool>.value(false);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Form(
                key: _newExhibitForm,
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
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Enter title.";
                            return null;
                          },
                          initialValue: widget.exhibit != null ? _title : '',
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
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Enter location.";
                            return null;
                          },
                          readOnly: true,
                          controller: _place,
                          key: ValueKey('location'),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Location',
                            icon: Icon(Icons.home),
                          ),
                          onTap: () async {
                            p = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: dotenv.env['google-api-key']!,
                                mode: Mode.overlay, // Mode.fullscreen
                                offset: 0,
                                radius: 1000,
                                strictbounds: false,
                                region: "",
                                language: "en",
                                sessionToken: UniqueKey().toString(),
                                components: [
                                  new Component(Component.country, "hr")
                                ],
                                types: [""],
                                hint: "Search Address",
                                startText: '');

                            //this should save the selected location and show it in form field
                            if (p != null)
                              _place.text = p!.description.toString();
                            else
                              return;
                          },
                        ),
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
                          child: Padding(
                            padding: padding,
                            child: DateTimePicker(
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Enter start date.";
                                return null;
                              },
                              initialValue: widget.exhibit != null
                                  ? _startDateTime.toString()
                                  : '',
                              type: DateTimePickerType.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              onChanged: (val) =>
                                  _startDateTime = DateTime.parse(val),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.calendar_today_outlined),
                                hintText: 'Start date',
                              ),
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
                          child: Padding(
                            padding: padding,
                            child: DateTimePicker(
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Enter end date.";
                                return null;
                              },
                              initialValue: widget.exhibit != null
                                  ? _endDate.toString()
                                  : '',
                              type: DateTimePickerType.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              onChanged: (val) =>
                                  _endDate = DateTime.parse(val),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(Icons.calendar_today_outlined),
                                hintText: 'End date',
                              ),
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
                      child: Padding(
                        padding: padding,
                        child: DateTimePicker(
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Enter opening time.";
                            return null;
                          },
                          initialValue:
                              widget.exhibit != null ? _openingTime : '',
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
                      child: Padding(
                        padding: padding,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Enter description.";
                            return null;
                          },
                          initialValue:
                              widget.exhibit != null ? _description : '',
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
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        String imageUrl;
                        XFile? newPicker = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 60);
                        if (newPicker != null) {
                          imageUrl =
                              await uploadExhibitImage(currentUser!, newPicker);
                          setState(() {
                            _images.add(imageUrl);
                            _unsubmittedImages.add(imageUrl);
                          });
                        }
                      },
                      child: Text('Upload image'),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: _images.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.network(
                                        _images[index],
                                        width: 300,
                                        height: 300,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Positioned(
                                      right: 3,
                                      top: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _imagesForDeletion
                                                    .add(_images[index]);
                                                _images.removeAt(index);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              })
                          : Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
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
                    isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              _postExhibit(context, currentUser!);
                            },
                            child: widget.exhibit == null
                                ? Text('Post exhibit')
                                : Text('Update exhibit'),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
