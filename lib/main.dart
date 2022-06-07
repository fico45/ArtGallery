import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/view/screens/auth_screen.dart';
import 'package:artgallery/view/screens/profile.dart';
import 'package:artgallery/view/widgets/drawer.dart';
import 'package:artgallery/view/widgets/exhibit/new_exhibit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(dotenv.env['oneSignalAppId']!);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
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
