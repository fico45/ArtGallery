import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showData() {
      print(ref.read(authControllerProvider.notifier).state);
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Member since: ' +
                      DateFormat("dd/MM/yyyy").format(ref
                          .read(authControllerProvider)!
                          .metadata
                          .creationTime!),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  // This will only work when photoURL is saved in the Firebase user object
                  /* CircleAvatar(
                    radius: 45,
                    child: Image(
                      image: NetworkImage(ref
                          .read(authControllerProvider.notifier)
                          .state!
                          .photoURL!),
                    ),
                  ), */
                  ElevatedButton(
                    onPressed: showData,
                    child: Text('Button'),
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
            ref.watch(exhibitListControllerProvider).when(
                  data: (data) => Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ExhibitCard(data[index]),
                      ),
                    ),
                  ),
                  error: (err, stack) => Text('There was an error.'),
                  loading: () => const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
    );
  }
}

class ItemListError extends StatelessWidget {
  final String message;

  const ItemListError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
