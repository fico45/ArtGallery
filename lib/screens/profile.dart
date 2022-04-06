import 'dart:convert';
import 'dart:developer';

import 'package:artgallery/data/model/exhibit_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  Future<List<Exhibit>> _getUserExhibits() async {
    List<Exhibit> exList = [];
    final qShot = await FirebaseFirestore.instance
        .collection('exhibits')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('startDate')
        .get();
    List<Map<dynamic, dynamic>> list = qShot.docs.map((e) {
      print(e.data());
      exList.add(Exhibit.fromMap(e.data()));
      return e.data();
    }).toList();
    log(list.toString());

    return exList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Member since: xx/yy/zzzz',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    child: Icon(Icons.people),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Your exhibits:',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            //ListView.builder goes here
            FutureBuilder<List<Exhibit>>(
                future: _getUserExhibits(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) =>
                              //create a widget for displaying exhibits and place it here
                              Text(snapshot.data![index].title))
                      : CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
