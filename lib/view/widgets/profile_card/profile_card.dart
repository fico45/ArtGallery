import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/model/user_model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileCard extends ConsumerWidget {
  final UserModel user;
  const ProfileCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
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
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3A9BDC),
              Color(0xFF29C5F6),
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Member since: ' +
                          DateFormat("dd/MM/yyyy").format(ref.watch(
                              authControllerProvider.select(
                                  (value) => value!.metadata.creationTime!))),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(user.image_url),
                ),
              ),
              Text(
                user.firstName + " " + user.lastName,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
