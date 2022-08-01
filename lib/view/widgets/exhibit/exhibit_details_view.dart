import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:artgallery/view/widgets/comments/show_comments_sheet.dart';
import 'package:artgallery/view/widgets/exhibit/new_exhibit.dart';
import 'package:artgallery/view/widgets/googlemaps.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artgallery/data/functions.dart';

class ExhibitDetailsView extends ConsumerStatefulWidget {
  Exhibit exhibit;
  ExhibitDetailsView({Key? key, required this.exhibit}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExhibitDetailsViewState();
}

class _ExhibitDetailsViewState extends ConsumerState<ExhibitDetailsView> {
  bool fav = false;

  Future<void> deleteExhibit({required BuildContext context}) async {
    await ref
        .read(exhibitListControllerProvider.notifier)
        .deleteExhibit(exhibit: widget.exhibit);
    Navigator.of(context).pop();
  }

  void customSetState({required Exhibit updatedExhibit}) {
    setState(() {
      widget.exhibit = updatedExhibit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authControllerProvider);
    final exhibitUser = ref.watch(getUserProvider(widget.exhibit.userId));
    return Hero(
      //TODO: ensure this is correct
      tag: widget.exhibit.id!,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: CustomAppBar(
              customActions: widget.exhibit.userId == currentUser!.uid
                  ? [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete exhibit?'),
                                  content: const Text(
                                      'Are you sure to delete exhibit?'),
                                  actions: [
                                    // The "Yes" button
                                    TextButton(
                                        onPressed: () {
                                          deleteExhibit(context: context);
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 24,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => NewExhibit(
                                      exhibit: widget.exhibit,
                                    )),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit))
                    ]
                  : [],
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.exhibit.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.exhibit.location.street!,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: exhibitUser.when(
                                  data: (data) => CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data.image_url),
                                      ),
                                  error: (error, st) =>
                                      Text('There seems to be an error.'),
                                  loading: () =>
                                      const CircularProgressIndicator())),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                exhibitUser.when(
                                  data: (data) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.firstName + ' ' + data.lastName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  error: (error, st) =>
                                      Text('There seems to be an error.'),
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  widget.exhibit.location.city.toString(),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: CarouselSlider(
                        items: generateImages(widget.exhibit.imageList),
                        options: CarouselOptions(
                          height: 250,
                          aspectRatio: 16 / 9,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Start date',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("${widget.exhibit.startDateTime.day}/" +
                            "${widget.exhibit.startDateTime.month}/" +
                            "${widget.exhibit.startDateTime.year}"),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Description",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.exhibit.description,
                          style: TextStyle(fontWeight: FontWeight.w300),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width - 60,
                          child: GoogleMaps(
                            exhibit: widget.exhibit,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              exportExhibitToCalendar(
                                exhibit: widget.exhibit,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 6.0),
                              height: 46,
                              width: 186,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_month),
                                  Text(
                                    "Export to calendar",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiaryContainer),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomAppBar(
            child: FittedBox(
              fit: BoxFit.none,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    showCommentSheet(
                      context: context,
                      exhibit: widget.exhibit,
                      setStateCallback: customSetState,
                    );
                  },
                  child: Container(
                    height: 46,
                    width: 186,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      bottom: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.comment),
                        Text(
                          widget.exhibit.comments != null
                              ? widget.exhibit.comments!.length.toString()
                              : '0',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Show comments",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
