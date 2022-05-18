import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/view/screens/dashboard.dart';
import 'package:artgallery/view/screens/profile.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainWrapper extends ConsumerStatefulWidget {
  final void Function() openDrawer;
  const MainWrapper({Key? key, required this.openDrawer}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  double widget1Opacity = 0.0;
  int currentPage = 1;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        widget1Opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        items: [
          SalomonBottomBarItem(
              icon: Icon(Icons.search), title: Text('Explore')),
          SalomonBottomBarItem(
              icon: Icon(Icons.home), title: Text('Dashobard')),
          SalomonBottomBarItem(
              icon: Icon(Icons.portrait), title: Text('Profile'))
        ],
        onTap: (i) => setState(() {
          currentPage = i;
        }),

        /* initialSelection: 1,
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
          } */
      ),
      body: AnimatedOpacity(
        opacity: widget1Opacity,
        duration: Duration(seconds: 1),
        child: _getPage(currentPage),
      ),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: CustomAppBar(
            openDrawer: IconButton(
              onPressed: widget.openDrawer,
              icon: const Icon(
                Icons.menu,
                size: 24,
              ),
            ),
          )),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Dashboard();
      case 1:
        return Dashboard();
      default:
        return ProfileView(
          openDrawer: IconButton(
            onPressed: widget.openDrawer,
            icon: const Icon(
              Icons.menu,
              size: 24,
            ),
          ),
        );
    }
  }
}
