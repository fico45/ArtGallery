import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/functions.dart';
import 'package:artgallery/view/widgets/exhibit/exhibit_view.dart';
import 'package:artgallery/view/widgets/exhibit/new_exhibit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        enableFeedback: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        label: Row(
          children: [
            Text(
              'Add new exhibit  ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Icon(Icons.add),
          ],
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewExhibit();
              },
            ),
            // in case user goes back (pops the screen) and doesn't finish with
            // posting the exhibit, this will ensure such images are deleted
            // from Firebase storage bucket
          ).then((value) => value != null
              ? deleteExhibitImages(ref.read(authControllerProvider)!, value)
              : null);
          ;
        },
      ),
      body: ExhibitView(),
    );
  }
}
