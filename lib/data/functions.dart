import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

List<Image> generateImages(List<String> imageURLs) {
  List<Image> exhibitImages = [];
  imageURLs.forEach((element) {
    exhibitImages.add(Image(image: NetworkImage(element)));
  });
  return exhibitImages;
}

Future<List<String>> uploadExhibitImages(
    User currentUser, List<File> _imagesForUpload) async {
  List<String> _images = [];
  String stamp = Timestamp.now().toString();
  for (int i = 0; i < _imagesForUpload.length; i++) {
    //get reference for uploaded image
    final imageRef = FirebaseStorage.instance
        .ref()
        .child('exhibit_images')
        .child(currentUser.uid)
        .child(i.toString() + '-' + stamp + '.jpg');
    //upload the imag
    await imageRef.putFile(File(_imagesForUpload[i].path));
    //get the image URL
    final _url = await imageRef.getDownloadURL();
    //and we add the URL to the images list
    _images.add(_url);
  }
  return _images;
}
