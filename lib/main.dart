import 'package:artgallery/screens/auth_screen.dart';
import 'package:artgallery/screens/dashboard.dart';
import 'package:artgallery/screens/main_wrapper.dart';
import 'package:artgallery/widgets/exhibit/new_exhibit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: Color.fromARGB(255, 57, 178, 89),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue)
            .copyWith(secondary: Colors.orangeAccent),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return MainWrapper();
          }
          return AuthScreen();
        },
      ),
      routes: {
        NewExhibit.routeName: (context) => NewExhibit(),
      },
    );
  }
}
