import 'package:artgallery/view/screens/dashboard.dart';
import 'package:artgallery/view/screens/explore.dart';
import 'package:artgallery/view/screens/profile.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWrapper extends ConsumerStatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: FancyBottomNavigation(
          initialSelection: 1,
          circleColor: Theme.of(context).colorScheme.onTertiaryContainer,
          inactiveIconColor: Theme.of(context).colorScheme.onSurface,
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
      body: _getPage(currentPage),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45), child: CustomAppBar()),
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
