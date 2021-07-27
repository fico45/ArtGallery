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
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          width: MediaQuery.of(context).size.width,
          height: 200,
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
