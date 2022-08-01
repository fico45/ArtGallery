import 'dart:io';

import 'package:artgallery/view/widgets/auth/auth_form.dart';
import 'package:artgallery/view/widgets/auth/auth_logo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({required this.callback, Key? key}) : super(key: key);

  final void Function({required bool newRegistrationStatus}) callback;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    String firstName,
    String lastName,
    String bio,
    XFile? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      widget.callback(newRegistrationStatus: false);
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        try {
          authResult = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          widget.callback(newRegistrationStatus: true);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
          ));
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        try {
          authResult = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_image')
              .child(authResult.user!.uid + '.jpg');
          await ref.putFile(File(image!.path));
          final url = await ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user!.uid)
              .set({
            'username': username,
            'email': email,
            'image_url': url,
            'firstName': firstName,
            'lastName': lastName,
            'reviewable': false,
            'bio': bio,
            'favorites': [],
            'createdAt': DateTime.now(),
          });
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
          ));
          setState(() {
            _isLoading = false;
          });
        }
        widget.callback(newRegistrationStatus: true);
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials';
      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: AnimatedLogo(),
          ),
          Expanded(
            flex: 2,
            child: AuthForm(
              _submitAuthForm,
              _isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
