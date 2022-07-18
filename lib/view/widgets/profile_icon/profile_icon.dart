import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/controllers/user_controller.dart';
import '../../../data/model/exhibit_model/exhibit_data_model.dart';
import '../profile_card/profile_card.dart';

class ProfileIcon extends ConsumerWidget {
  final Exhibit exhibit;
  const ProfileIcon(this.exhibit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: 0,
      child: InkWell(
        onTap: (() {
          showDialog(
            context: context,
            builder: (context) => Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(getUserProvider(exhibit.userId)).when(
                      data: (data) {
                        return Center(
                          child: ProfileCard(
                            user: data,
                            userId: exhibit.userId,
                          ),
                        );
                      },
                      error: (error, st) => Text('There seems to be an error.'),
                      loading: () {
                        return Center(
                          child: Card(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 2,
                              ),
                            ),
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
              },
            ),
          );
        }),
        child: ref.watch(getUserProvider(exhibit.userId)).when(
            data: (data) => CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(data.image_url),
                ),
            error: (error, st) => CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('error_icon.png'),
                ),
            loading: () => CircularProgressIndicator()),
        //NetworkImage(userImage),
      ),
    );
  }
}
