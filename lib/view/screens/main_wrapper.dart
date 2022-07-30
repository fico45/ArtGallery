import 'package:artgallery/data/controllers/exhibit_list_controller.dart';
import 'package:artgallery/view/screens/dashboard.dart';
import 'package:artgallery/view/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWrapper extends ConsumerStatefulWidget {
  final void Function() openDrawer;
  const MainWrapper({Key? key, required this.openDrawer}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Dashboard(),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: CustomAppBar(
            customActions: [
              Consumer(
                builder: (context, ref, widget) => IconButton(
                  onPressed: () {
                    ref
                        .read(exhibitListControllerProvider.notifier)
                        .retrieveAllExhibits();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 24,
                  ),
                ),
              ),
            ],
            openDrawer: IconButton(
              onPressed: widget.openDrawer,
              icon: const Icon(
                Icons.menu,
                size: 24,
              ),
            ),
          )),
    );
  }
}
