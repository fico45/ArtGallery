import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/screens/edit_profile.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/controllers/auth_controller.dart';

class ProfileView extends ConsumerStatefulWidget {
  final Widget? openDrawer;
  static const routeName = '/profile';
  final String? userId;
  ProfileView({
    Key? key,
    this.openDrawer,
    this.userId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    const double containerWidth = 90;
    const double containerHeight = 65;
    final String uid = widget.userId == null
        ? ref.read(authControllerProvider)!.uid
        : widget.userId!;
    final user = widget.userId == null
        ? ref.watch(userControllerProvider)
        : ref.watch(getUserProvider(widget.userId!));
    final isMe = widget.userId == null ? true : false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            fit: StackFit.loose,
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: 280,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              widget.openDrawer != null
                  ? Positioned(
                      child: widget.openDrawer!,
                      left: 5,
                      top: 40,
                    )
                  : SizedBox(),
              Positioned.fill(
                top: 45,
                child: user.when(
                    data: (data) {
                      return Flex(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            data.firstName + " " + data.lastName,
                            style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: containerHeight,
                                  width: containerWidth,
                                  child: Material(
                                    clipBehavior: Clip.antiAlias,
                                    borderRadius: BorderRadius.circular(25),
                                    child: InkWell(
                                      splashColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      onTap: () => launchUrl(Uri(
                                          scheme: "mailto",
                                          path: data.email,
                                          queryParameters: {
                                            "subject": "[ArtGallery]"
                                          })),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Contact',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                            ),
                                          ),
                                          Icon(
                                            Icons.mail,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (isMe)
                                  Container(
                                    height: containerHeight,
                                    width: containerWidth,
                                    child: Material(
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(25),
                                      child: InkWell(
                                        splashColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfileScreen()));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Edit profile',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                              ),
                                            ),
                                            Icon(
                                              Icons.edit,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(data.image_url),
                            ),
                          ),
                        ],
                      );
                    },
                    error: (e, st) => Text('There was an error.'),
                    loading: () => Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        )),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: user.when(
              data: (data) => Text(data.bio),
              error: (e, st) => Text('There was an error.'),
              loading: () => LinearProgressIndicator(),
            ),
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Your exhibits:',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
          ref.watch(exhibitListControllerProvider).when(
                data: (data) {
                  List<Exhibit> currentUserExhibits = data
                      .where(
                        (element) => element.userId == uid,
                      )
                      .toList();
                  return Expanded(
                    child: currentUserExhibits.isNotEmpty
                        ? ListView.builder(
                            itemCount: currentUserExhibits.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ExhibitTile(
                                  exhibit: currentUserExhibits[index]),
                            ),
                          )
                        : Center(child: Text('No exhibits!')),
                  );
                },
                error: (err, stack) => Text('There was an error.'),
                loading: () => const CircularProgressIndicator(),
              ),
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
