import 'package:artgallery/data/model/user_model/user_data_model.dart';
import 'package:artgallery/view/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileCard extends ConsumerWidget {
  final UserModel user;
  final String? userId;
  const ProfileCard({
    required this.user,
    this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Card(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              width: MediaQuery.of(context).size.width,
              child: Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.firstName + " " + user.lastName,
                              style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                            Text(
                              'Member since:\n' +
                                  DateFormat("dd/MM/yyyy")
                                      .format(user.createdAt),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(user.image_url),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView(
                                      userId: userId,
                                    ))),
                        child: Text('Go to profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
