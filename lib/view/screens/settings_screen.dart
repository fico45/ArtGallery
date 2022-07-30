import 'package:artgallery/data/providers/color_provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/appbar.dart';

class Settings extends StatefulWidget {
  final Widget openDrawer;
  const Settings({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: CustomAppBar(
          openDrawer: widget.openDrawer,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              Center(
                child: Text(
                  'Select your color',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return InkWell(
                        onTap: () async {
                          var newColor = await showColorPickerDialog(
                              context, Theme.of(context).colorScheme.secondary);

                          ref.read(colorProvider.notifier).state = newColor;
                        },
                        child: ColorIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
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
