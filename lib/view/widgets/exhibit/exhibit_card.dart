import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_details_view.dart';
import 'package:flutter/material.dart';

class ExhibitCard extends StatelessWidget {
  const ExhibitCard(this.exhibit, {Key? key}) : super(key: key);
  final Exhibit exhibit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExhibitDetailsView(exhibit),
            ),
          ),
          child: Card(
            elevation: 6,
            shadowColor: Theme.of(context).colorScheme.secondary,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: NetworkImage(exhibit.exhibitImageUrl!),
                      fit: BoxFit.cover,
                      opacity: 0.4)),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          exhibit.title,
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  blurRadius: 10)
                            ],
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.date_range),
                        Text(exhibit.startDate.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.timer),
                        Text(exhibit.openingTime),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(exhibit.description),
                        )
                      ],
                    ),
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
        )
      ],
    );
  }
}
