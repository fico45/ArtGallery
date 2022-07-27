import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:flutter/material.dart';

import '../../../data/model/comment_model/comment_data_model.dart';

Future showCommentSheet(
    {required BuildContext context, required Exhibit exhibit}) async {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: true,
      context: context,
      builder: (context) => CommentViewSheet(
            exhibit: exhibit,
          ));
}

class CommentViewSheet extends StatefulWidget {
  CommentViewSheet({required this.exhibit, Key? key}) : super(key: key);
  Exhibit exhibit;
  @override
  State<CommentViewSheet> createState() => _CommentViewSheetState();
}

class _CommentViewSheetState extends State<CommentViewSheet> {
  final EdgeInsets padding =
      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Padding(
            padding: padding,
            child: Center(
              child: Text(
                'Comments',
                style: TextStyle(
                  fontFamily: 'VarelaRound',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  //fontFamily: "VarelaRound-regular",
                ),
              ),
            ),
          ),
          Container(
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter a comment...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
