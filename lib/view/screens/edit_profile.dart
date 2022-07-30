import 'dart:io';

import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/user_model/user_data_model.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  XFile? newImage;

  void _loadInitialData(UserModel user) {
    _firstName = user.firstName;
    _lastName = user.lastName;
    _username = user.username;
    _bio = user.bio;
    _userImageUrl = user.image_url;
    _email = user.email;
    _reviewable = user.reviewable;
    _favorites = user.favorites;
  }

  late String _firstName;
  late String _lastName;
  late String _username;
  late String _bio;
  late String _userImageUrl;
  late String _email;
  late bool _reviewable;
  late List<String> _favorites;

  @override
  Widget build(BuildContext context) {
    ref
        .read(userControllerProvider)
        .whenData((value) => _loadInitialData(value));

    final EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0);
    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        var picked = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 60);
                        setState(() {
                          newImage = picked;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(_userImageUrl),
                            ),
                          ),
                          Text(
                            'Change image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    newImage != null
                        ? Row(
                            children: [
                              Icon(
                                Icons.arrow_circle_right,
                                size: 40,
                              ),
                              CircleAvatar(
                                radius: 48,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      FileImage(File(newImage!.path)),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: _firstName,
                    onChanged: (value) => _firstName = value,
                    key: ValueKey('firstName'),
                    decoration: InputDecoration(
                      contentPadding: padding,
                      border: InputBorder.none,
                      labelText: 'First Name',
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: _lastName,
                    onChanged: (value) => _lastName = value,
                    key: ValueKey('lastName'),
                    decoration: InputDecoration(
                      contentPadding: padding,
                      border: InputBorder.none,
                      labelText: 'Last name',
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: _username,
                    onChanged: (value) => _username = value,
                    key: ValueKey('username'),
                    decoration: InputDecoration(
                      contentPadding: padding,
                      border: InputBorder.none,
                      labelText: 'Username',
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: _bio,
                    onChanged: (value) => _bio = value,
                    key: ValueKey('bio'),
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: padding,
                      border: InputBorder.none,
                      labelText: 'Bio',
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    var currentAuthUser = ref.read(authControllerProvider);
                    if (newImage != null) {
                      /* await FirebaseStorage.instance
                          .refFromURL(_userImageUrl)
                          .delete(); */
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('user_image')
                          .child(currentAuthUser!.uid + '.jpg');
                      await ref.delete();
                      await ref.putFile(File(newImage!.path));
                      _userImageUrl = await ref.getDownloadURL();
                    }

                    ref.read(userControllerProvider.notifier).updateUserData(
                          currentAuthUser!.uid,
                          UserModel(
                            email: _email,
                            image_url: _userImageUrl,
                            username: _username,
                            firstName: _firstName,
                            lastName: _lastName,
                            reviewable: _reviewable,
                            bio: _bio,
                            favorites: _favorites,
                          ),
                        );
                    Navigator.pop(context);
                  },
                  child: Text('Update profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
