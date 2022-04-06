import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Exhibit {
  DateTime createdAt;
  String description;
  DateTime startDate;
  DateTime endDate;
  String openingTime;
  String? exhibitImageUrl;
  String location;
  String title;
  String userId;
  String userImageUrl;
  String username;

  Exhibit({
    required this.createdAt,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.openingTime,
    this.exhibitImageUrl,
    required this.location,
    required this.title,
    required this.userId,
    required this.userImageUrl,
    required this.username,
  });

  Exhibit.fromMap(
    Map<String, dynamic> map,
  )   : createdAt = DateTime.parse((map['createdAt']).toDate().toString()),
        description = (map['description']),
        startDate = DateTime.parse((map['startDate'])),
        endDate = DateTime.parse((map['endDate'])),
        openingTime = (map['openingTime']),
        exhibitImageUrl = (map['exhibitImageUrl']),
        location = (map['location']),
        title = (map['title']),
        userId = (map['userId']),
        userImageUrl = (map['userImage']),
        username = (map['username']);

  Exhibit.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);

  factory Exhibit.fromJson(Map<String, dynamic> json) {
    return Exhibit(
      createdAt: json['createdAt'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      openingTime: json['openingTime'],
      exhibitImageUrl: json['exhibitImageUrl'],
      location: json['location'],
      title: json['title'],
      userId: json['userId'],
      userImageUrl: json['userImageUrl'],
      username: json['username'],
    );
  }
}

class Exhibits {
  List<Exhibit> exhibits;

  Exhibits({
    required this.exhibits,
  });

  factory Exhibits.fromJson(Map<String, dynamic> json) {
    return Exhibits(exhibits: json['exhibit']);
  }
}
