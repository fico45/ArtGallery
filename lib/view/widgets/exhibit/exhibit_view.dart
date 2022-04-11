import 'package:artgallery/view/widgets/exhibit/exhibit_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ExhibitView extends StatelessWidget {
  const ExhibitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('exhibits')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, AsyncSnapshot exhibitSnapshot) {
              if (exhibitSnapshot.connectionState == ConnectionState.waiting ||
                  exhibitSnapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final exhibitDocs = exhibitSnapshot.data.docs;

              return Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ExhibitCard(
                        // exhibitDocs[index]['image_url'],
                        ),
                  ),
                ),
              );
            },
          );
          /* return Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ExhibitCard(userImage),
          ); */
        });
  }
}
