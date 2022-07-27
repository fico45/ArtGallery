// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map json) => _$_Comment(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      commentText: json['commentText'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'commentText': instance.commentText,
      'userId': instance.userId,
    };
