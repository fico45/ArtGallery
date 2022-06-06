import 'dart:io';

import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/view/widgets/appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userControllerProvider);
    final EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0);
    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
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
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(user.value!.image_url),
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
                  initialValue: user.value!.firstName,
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
                  initialValue: user.value!.lastName,
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
                  initialValue: user.value!.username,
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
                  initialValue: user.value!.bio,
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
            ],
          ),
        ),
      ),
    );
  }
}
