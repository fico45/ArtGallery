import 'package:flutter/material.dart';

class ExhibitCard extends StatelessWidget {
/*   const ExhibitCard(this.userImage);
  final String userImage; */

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          ),
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
                      "Exhibit title",
                      style: TextStyle(
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
                    Text('DD/MM/YYYY'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.timer),
                    Text('HH:MM'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          "This will be a very long description of the exhibit. It might not be long, actually, but for safety, let's make it very long."),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: null,
            //NetworkImage(userImage),
          ),
        )
      ],
    );
  }
}
