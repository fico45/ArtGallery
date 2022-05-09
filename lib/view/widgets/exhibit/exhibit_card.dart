import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExhibitCard extends StatelessWidget {
  const ExhibitCard(this.exhibit, {Key? key}) : super(key: key);
  final Exhibit exhibit;

  static BorderRadius radius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.antiAlias,
          children: <Widget>[
            InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExhibitDetailsView(exhibit: exhibit),
                  ),
                );
              },
              child: Card(
                elevation: 6,
                shape: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: radius,
                    image: DecorationImage(
                      image: NetworkImage(
                        exhibit.imageList[0],
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                    //hey implement exhibitImageUrl as imageList (list of images) for carousel_slider
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withOpacity(0.85),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  exhibit.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                              ),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.85),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.date_range),
                                Text(exhibit.startDate.toString()),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.timer),
                                Text(exhibit.openingTime),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(exhibit.userImageUrl),
                //NetworkImage(userImage),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(exhibit.location.country!),
          ],
        ),
        Divider(),
      ],
    );
  }
}
