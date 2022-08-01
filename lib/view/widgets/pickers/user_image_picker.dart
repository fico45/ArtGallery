import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  final void Function(XFile? pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;

  void _pickImage() async {
    bool? isCamera = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select image from camera or gallery?"),
              actions: [
                // The "Yes" button
                TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Camera')),
                TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Gallery'))
              ],
            ));
    if (isCamera != null) {
      final pickedImageFile = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 50,
          maxHeight: 150,
          maxWidth: 150);
      setState(() {
        _pickedImage = pickedImageFile;
      });
      widget.imagePickFn(pickedImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add Image')),
      ],
    );
  }
}
