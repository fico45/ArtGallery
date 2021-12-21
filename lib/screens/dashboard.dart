import 'package:artgallery/widgets/custom_page_route.dart';
import 'package:artgallery/widgets/exhibit/exhibit_view.dart';
import 'package:artgallery/widgets/exhibit/new_exhibit.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, CustomPageRoute(NewExhibit(), Alignment.bottomCenter));
        },
      ),
      body: ExhibitView(),
    );
  }
}
