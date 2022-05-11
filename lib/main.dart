import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/view/screens/auth_screen.dart';
import 'package:artgallery/view/screens/profile.dart';
import 'package:artgallery/view/widgets/drawer.dart';
import 'package:artgallery/view/widgets/exhibit/new_exhibit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final container = ProviderContainer();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.read(authControllerProvider.notifier);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: StreamBuilder(
        stream: authControllerState.stream,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return CustomDrawer();
          }
          return AuthScreen();
        },
      ),
      routes: {
        NewExhibit.routeName: (context) => NewExhibit(),
        ProfileView.routeName: (context) => ProfileView(),
      },
    );
  }
}
