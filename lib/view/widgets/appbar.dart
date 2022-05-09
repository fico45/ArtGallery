import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  final Exhibit? exhibit;
  const CustomAppBar({Key? key, this.exhibit}) : super(key: key);

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider);
    return AppBar(
      toolbarHeight: 70.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width - 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
                  widget.exhibit != null && widget.exhibit!.userId == user!.uid
                      ? [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(exhibitListControllerProvider.notifier)
                                  .deleteExhibit(exhibit: widget.exhibit!);
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              size: 24,
                            ),
                          ),
                        ]
                      : [],
            ),
          ),
        )
      ],
    );
  }
}
