import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      DateFormat("dd/MM/yyyy").format(ref.watch(
                          authControllerProvider.select(
                              (value) => value!.metadata.creationTime!))),
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
                  ref.watch(userControllerProvider).when(
                      data: (data) => CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(data.image_url),
                          ),
                      error: (e, st) => Text('There was an error.'),
                      loading: () => const CircularProgressIndicator()),

                  Text(
                    ref.watch(authControllerProvider
                        .select((value) => value!.email!)),
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
                  data: (data) {
                    List<Exhibit> currentUserExhibits = data
                        .where(
                          (element) =>
                              element.userId ==
                              ref.watch(authControllerProvider
                                  .select((value) => value!.uid)),
                        )
                        .toList();
                    return Expanded(
                      child: ListView.builder(
                        itemCount: currentUserExhibits.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ExhibitCard(currentUserExhibits[index]),
                        ),
                      ),
                    );
                  },
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
