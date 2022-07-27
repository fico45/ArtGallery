import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'model/exhibit_model/exhibit_data_model.dart';

List<Image> generateImages(List<String> imageURLs) {
  List<Image> exhibitImages = [];
  imageURLs.forEach((element) {
    exhibitImages.add(Image(image: NetworkImage(element)));
  });
  return exhibitImages;
}

Future<String> uploadExhibitImage(
    User currentUser, XFile _imageForUpload) async {
  String stamp = Timestamp.now().toString();

  //get reference for uploaded image
  final imageRef = FirebaseStorage.instance
      .ref()
      .child('exhibit_images')
      .child(currentUser.uid)
      .child(stamp + '.jpg');
  //upload the imag
  await imageRef.putFile(File(_imageForUpload.path));
  //get the image URL
  final _url = await imageRef.getDownloadURL();
  //and we add the URL to the images list

  return _url;
}

Future<void> deleteExhibitImages(
    User currentUser, List<String> _imagesForDeletion) async {
  for (var image in _imagesForDeletion) {
    await FirebaseStorage.instance.refFromURL(image).delete();
  }
}

void exportExhibitToCalendar({
  required Exhibit exhibit,
  int? notificationDelay,
  required bool shouldNotify,
}) async {
  log('test!');
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  Event event = Event(exhibit.userId, eventId: exhibit.id, reminders: [
    if (shouldNotify)
      Reminder(
        minutes: notificationDelay,
      ),
  ]);
  try {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
  } catch (e) {}
  _deviceCalendarPlugin.createOrUpdateEvent(event);
}
