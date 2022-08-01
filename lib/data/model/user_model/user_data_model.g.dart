// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map json) => _$_UserModel(
      email: json['email'] as String,
      image_url: json['image_url'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      reviewable: json['reviewable'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      bio: json['bio'] as String,
      favorites:
          (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'image_url': instance.image_url,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'reviewable': instance.reviewable,
      'createdAt': instance.createdAt.toIso8601String(),
      'bio': instance.bio,
      'favorites': instance.favorites,
    };
