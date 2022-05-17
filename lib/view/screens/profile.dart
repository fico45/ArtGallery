import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_card.dart';
import 'package:artgallery/view/widgets/profile_card/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerWidget {
  final Widget? openDrawer;
  static const routeName = '/profile';
  final String? userId;
  ProfileView({
    Key? key,
    this.openDrawer,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = userId == null
        ? ref.watch(userControllerProvider)
        : ref.watch(getUserProvider(userId!));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(
          openDrawer: openDrawer,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              user.when(
                  data: (data) {
                    return Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 52,
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: CircleAvatar(
                              radius: 49,
                              backgroundImage: NetworkImage(data.image_url),
                            ),
                          ),
                        ),
                        Text(data.bio),
                      ],
                    );
                  },
                  error: (e, st) => Text('There was an error.'),
                  loading: () => const CircularProgressIndicator()),
              Divider(),
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
