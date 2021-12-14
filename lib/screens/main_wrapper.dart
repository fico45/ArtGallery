import 'package:artgallery/screens/dashboard.dart';
import 'package:artgallery/screens/explore.dart';
import 'package:artgallery/screens/profile.dart';
import 'package:artgallery/widgets/background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
          initialSelection: 1,
          circleColor: Colors.orange,
          inactiveIconColor: Colors.blue,
          tabs: [
            TabData(iconData: Icons.search, title: 'Explore'),
            TabData(iconData: Icons.home, title: 'Dashboard'),
            TabData(iconData: Icons.portrait, title: 'Profile')
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          }),
      body: Stack(children: [
        //an animated background which would, potentially, be implemented sometime
        //AnimatedBackground(),
        Container(
          child: _getPage(currentPage),
        ),
      ]),
      appBar: AppBar(
        title: Text('Flutter Art Gallery'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Settings'),
                        ],
                      ),
                    ),
                    value: 'settings'),
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Explore();
      case 1:
        return Dashboard();
      default:
        return ProfileView();
    }
  }
}
