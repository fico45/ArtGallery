import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/exhibit_model/exhibit_data_model.dart';

class ExhibitTile extends ConsumerWidget {
  final Exhibit exhibit;
  const ExhibitTile(this.exhibit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      Card(
        child: ListTile(
          leading: Image.network(exhibit.imageList[0]),
          title: Text(exhibit.title),
          subtitle: Text(exhibit.description),
          trailing: Text(exhibit.startDateTime.toString()),
        ),
      ),
    ]);
  }
}
