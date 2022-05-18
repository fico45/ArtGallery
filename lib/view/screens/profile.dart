import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends ConsumerWidget {
  final Widget? openDrawer;
  static const routeName = '/profile';
  final String? userId;
  ProfileView({
    Key? key,
    this.openDrawer,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double containerWidth = 70;
    const double containerHeight = 55;
    final user = userId == null
        ? ref.watch(userControllerProvider)
        : ref.watch(getUserProvider(userId!));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /* appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(
          openDrawer: openDrawer,
        ),
      ), */
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            fit: StackFit.loose,
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: 250,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              openDrawer != null
                  ? Positioned(
                      child: openDrawer!,
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child: InkWell(
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
                                          'Favorites',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          ),
                                        ),
                                        Icon(
                                          Icons.favorite,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: containerHeight,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child: InkWell(
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
                                Container(
                                  height: containerHeight,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child: InkWell(
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
                                          'Reviews',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          ),
                                        ),
                                        Icon(
                                          Icons.heart_broken,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                          /* Text(data.bio), */
                        ],
                      );
                    },
                    error: (e, st) => Text('There was an error.'),
                    loading: () => const CircularProgressIndicator()),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          Text("Short bio!"),
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
                        (element) => element.userId == userId,
                      )
                      .toList();
                  return Expanded(
                    child: currentUserExhibits.isNotEmpty
                        ? ListView.builder(
                            itemCount: currentUserExhibits.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ExhibitCard(currentUserExhibits[index]),
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
