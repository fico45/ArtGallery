import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  final Widget? openDrawer;
  final List<Widget>? customActions;
  const CustomAppBar({Key? key, this.openDrawer, this.customActions})
      : super(key: key);

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0.0,
      actions: widget.customActions,
      leading: widget.openDrawer,
    );
  }
}
