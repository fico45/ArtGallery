import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_data_model.freezed.dart';
part 'comment_data_model.g.dart';

@freezed
abstract class Comment implements _$Comment {
  const Comment._();

  const factory Comment({
    String? id,
    required DateTime createdAt,
    required String commentText,
    required String userId,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  factory Comment.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Comment.fromJson(data).copyWith(id: doc.id);
  }
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
