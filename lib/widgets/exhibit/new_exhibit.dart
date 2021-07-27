import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewExhibit extends StatefulWidget {
  static const routeName = '/new-exhibit';

  const NewExhibit({Key? key}) : super(key: key);

  @override
  _NewExhibitState createState() => _NewExhibitState();
}

class _NewExhibitState extends State<NewExhibit> {
  final _controller = new TextEditingController();
  var _description = '';
  var _title = '';
  var _location = '';
  var _dateTime = '';

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
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exhibit'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              key: ValueKey('title'),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (value) {
                _title = value;
              },
            ),
            TextFormField(
              key: ValueKey('location'),
              decoration: InputDecoration(
                labelText: 'Location',
              ),
              onChanged: (value) {
                _location = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
