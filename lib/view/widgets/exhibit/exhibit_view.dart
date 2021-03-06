import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                                child: ExhibitCard(data[index]),
                              )),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'No exhibits! 🎉',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
          error: (err, stack) => Text('There was an error.'),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
