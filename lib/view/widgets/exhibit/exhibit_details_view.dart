import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter/material.dart';

class ExhibitDetailsView extends StatefulWidget {
  final Exhibit exhibit;
  const ExhibitDetailsView(this.exhibit, {Key? key}) : super(key: key);

  @override
  State<ExhibitDetailsView> createState() => _ExhibitDetailsViewState();
}

class _ExhibitDetailsViewState extends State<ExhibitDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            stretch: true,
            centerTitle: true,
            title: Text(widget.exhibit.title),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
            ),
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
                child: Image(
                  image: NetworkImage(widget.exhibit.exhibitImageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                      padding: EdgeInsets.all(8),
                      width: 100,
                      child: Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
