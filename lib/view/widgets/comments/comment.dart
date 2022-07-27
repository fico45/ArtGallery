import 'package:artgallery/data/controllers/user_controller.dart';
import 'package:artgallery/data/model/comment_model/comment_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentBubble extends ConsumerWidget {
  const CommentBubble({required this.comment, Key? key}) : super(key: key);
  final Comment comment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ref.watch(getUserProvider(comment.userId)).when(
                      data: (data) => Text(
                            data.username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer),
                          ),
                      error: (e, st) => Text('There was an error.'),
                      loading: () {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                  Text(
                    comment.commentText,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 10,
          child: ref.watch(getUserProvider(comment.userId)).when(
              data: (data) => CircleAvatar(
                    backgroundImage: NetworkImage(data.image_url),
                  ),
              error: (e, st) => Text('There was an error.'),
              loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
