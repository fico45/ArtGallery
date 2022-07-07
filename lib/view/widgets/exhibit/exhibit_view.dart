import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'exhibit_tile.dart';

class ExhibitView extends ConsumerWidget {
  const ExhibitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(exhibitListControllerProvider).when(
          data: (data) => data.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExhibitTile(data[index]),
                              )),
                    ),
                  ],
                )
              : Text('No exhibits!'),
          error: (err, stack) => Text('There was an error.'),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
