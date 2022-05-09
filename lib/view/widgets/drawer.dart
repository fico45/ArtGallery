import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/view/screens/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: MainWrapper(),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 64.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) =>
                        ref.watch(userControllerProvider).when(
                              data: (data) =>
                                  Image(image: NetworkImage(data.image_url)),
                              error: (e, st) => Icon(Icons.cancel),
                              loading: () => const CircularProgressIndicator(
                                strokeWidth: 10,
                              ),
                            ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.home,
                    size: 24,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person),
                  onTap: () {},
                  title: Text(
                    'Profile',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.favorite,
                    size: 24,
                  ),
                  title: Text(
                    'Favourites',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  onTap: () {},
                  title: Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
                Divider(),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 24,
                      ),
                      onTap: () =>
                          ref.read(authControllerProvider.notifier).signOut(),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    );
                  },
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
