import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
              Column(
                children: [
                  TextField(),
                  TextField(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
