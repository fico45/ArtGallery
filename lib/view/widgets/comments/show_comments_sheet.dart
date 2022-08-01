import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/view/widgets/comments/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/comment_model/comment_data_model.dart';
import 'package:artgallery/data/controllers/exhibit_list_controller.dart';

Future showCommentSheet({
  required BuildContext context,
  required Exhibit exhibit,
  required void Function({required Exhibit updatedExhibit}) setStateCallback,
}) async {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      builder: (context) => CommentViewSheet(
            exhibit: exhibit,
            setStateCallback: setStateCallback,
          ));
}

class CommentViewSheet extends StatefulWidget {
  CommentViewSheet(
      {required this.exhibit, Key? key, required this.setStateCallback})
      : super(key: key);
  Exhibit exhibit;
  final void Function({required Exhibit updatedExhibit}) setStateCallback;
  @override
  State<CommentViewSheet> createState() => _CommentViewSheetState();
}

class _CommentViewSheetState extends State<CommentViewSheet> {
  TextEditingController _textComment = TextEditingController();
  void clearTextController() {
    _textComment.clear();
  }

  final EdgeInsets padding =
      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Center(),
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
            child: (widget.exhibit.comments != null &&
                    widget.exhibit.comments!.isNotEmpty)
                ? SingleChildScrollView(
                    child: ListView.builder(
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.exhibit.comments!.length,
                      itemBuilder: ((context, index) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                          ),
                          child: CommentBubble(
                            comment: widget.exhibit.comments![index],
                          ),
                        );
                      }),
                    ),
                  )
                : Center(
                    child: Text('No comments yet!'),
                  ),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _textComment,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter a comment...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        Exhibit newExhibit = await ref
                            .read(exhibitListControllerProvider.notifier)
                            .postExhibitComment(
                                exhibit: widget.exhibit,
                                comment: Comment(
                                    id: widget.exhibit.id!,
                                    createdAt: DateTime.now(),
                                    commentText: _textComment.text,
                                    userId:
                                        ref.read(authControllerProvider)!.uid));
                        clearTextController();
                        setState(() {
                          widget.exhibit = newExhibit;
                        });
                        widget.setStateCallback(updatedExhibit: newExhibit);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
