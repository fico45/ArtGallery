import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/model/exhibit_model/exhibit_data_model.dart';
import 'exhibit_details_view.dart';

class ExhibitTile extends StatelessWidget {
  const ExhibitTile({required this.exhibit, Key? key}) : super(key: key);
  final Exhibit exhibit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExhibitDetailsView(exhibit: exhibit),
          ),
        );
      },
      child: ListTile(
        dense: true,
        minLeadingWidth: 80,
        hoverColor: Colors.red,
        horizontalTitleGap: 10,
        leading: Image.network(exhibit.imageList[0]),
        title: Text(exhibit.title),
        subtitle: Text(exhibit.description),
      ),
    );
  }
}
