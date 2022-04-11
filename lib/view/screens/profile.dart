import 'package:artgallery/data/model/exhibit_data_model_old.dart';
import 'package:flutter/material.dart';
import 'package:artgallery/data/providers/exhibit_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artgallery/data/providers/exhibit_data_provider.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Exhibit>> exhibitProvider =
        ref.watch(ExhibitStateNotifier().userExhibitsProvider);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Member since: xx/yy/zzzz',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    child: Icon(Icons.people),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
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
            //ListView.builder goes here
            exhibitProvider.when(
                data: (exhibitProvider) => ListView.builder(
                      itemCount: exhibitProvider.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.school),
                          title: Text(exhibitProvider[index].title),
                        );
                      },
                    ),
                error: (err, stack) => Text('Error: ' + err.toString()),
                loading: () => CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
