import 'package:artgallery/data/model/exhibit_data_model_old.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExhibitStateNotifier extends ChangeNotifier {
  List<Exhibit> myExhibits = [];

  void getUserExhibits() async {
    await FirebaseFirestore.instance
        .collection('exhibits')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('startDate')
        .get()
        .then((value) => value.docs.map((e) {
              print(e.data());
              myExhibits.add(Exhibit.fromMap(e.data()));
              return e.data();
            }).toList());
    notifyListeners();
    return;
  }

  final userExhibitsProvider = FutureProvider<List<Exhibit>>((ref) async {
    List<Exhibit> exList = [];
    await FirebaseFirestore.instance
        .collection('exhibits')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('startDate')
        .get()
        .then((value) => value.docs.map((e) {
              print(e.data());
              exList.add(Exhibit.fromMap(e.data()));
              return e.data();
            }).toList());

    return exList;
  });
}
