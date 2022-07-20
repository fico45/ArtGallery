import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future showCalendarExportSheet({
  required BuildContext context,
  required Exhibit exhibit,
}) async {
  return showModalBottomSheet(
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
  late String _notificationTime =
      DateFormat("HH:mm").format(widget.exhibit.startDateTime);
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
              AnimatedContainer(
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
                child: DateTimePicker(
                  enabled: shouldNotify,
                  initialValue: _notificationTime,
                  initialTime: TimeOfDay(
                      hour: int.parse(
                          _notificationTime[0] + _notificationTime[1]),
                      minute: int.parse(
                          _notificationTime[3] + _notificationTime[4])),
                  onChanged: (val) => _notificationTime = val,
                  type: DateTimePickerType.time,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  decoration: InputDecoration(
                    contentPadding: padding,
                    border: InputBorder.none,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Icon(
                        Icons.timer,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: padding,
          child: Center(
            child: OutlinedButton(
              onPressed: () {},
              child: Text('Export to Calendar'),
              style: ButtonStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
