import 'package:artgallery/data/functions.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

Future showCalendarExportSheet({
  required BuildContext context,
  required Exhibit exhibit,
}) async {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
    enableDrag: false,
    elevation: 5,
    context: context,
    builder: (context) => CalendarExportSheet(
      exhibit: exhibit,
    ),
  );
}

class CalendarExportSheet extends StatefulWidget {
  const CalendarExportSheet({required this.exhibit, Key? key})
      : super(key: key);
  final Exhibit exhibit;
  @override
  State<CalendarExportSheet> createState() => _CalendarExportSheetState();
}

class _CalendarExportSheetState extends State<CalendarExportSheet> {
  int notificationTime = 5;
  final EdgeInsets padding =
      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0);
  bool shouldNotify = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: padding,
          child: Text(
            'Would you like to get notified before exhibit opens?',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              //fontFamily: "VarelaRound-regular",
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Row(
            children: [
              Container(
                width: 200,
                height: 50,
                child: CheckboxListTile(
                  title: Text("Notification"),
                  value: shouldNotify,
                  onChanged: (newValue) {
                    setState(() {
                      shouldNotify = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              IgnorePointer(
                ignoring: !shouldNotify,
                child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: shouldNotify
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  duration: Duration(
                    milliseconds: 600,
                  ),
                  child: Center(
                      child: NumberPicker(
                    textStyle: TextStyle(
                      fontFamily: 'VarelaRound',
                    ),
                    itemWidth: 30,
                    maxValue: 120,
                    minValue: 1,
                    itemCount: 5,
                    axis: Axis.horizontal,
                    value: notificationTime,
                    onChanged: (value) => setState(() {
                      notificationTime = value;
                    }),
                  )),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: padding,
          child: Center(
            child: OutlinedButton(
              onPressed: () {
                exportExhibitToCalendar(
                    exhibit: widget.exhibit,
                    notificationDelay: notificationTime,
                    shouldNotify: shouldNotify);
              },
              child: Text('Confirm'),
            ),
          ),
        ),
      ],
    );
  }
}
