// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exhibit_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Exhibit _$$_ExhibitFromJson(Map json) => _$_Exhibit(
      id: json['id'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      openingTime: json['openingTime'] as String,
      imageList:
          (json['imageList'] as List<dynamic>).map((e) => e as String).toList(),
      location: json['location'] as String,
      title: json['title'] as String,
      userId: json['userId'] as String,
      userImageUrl: json['userImageUrl'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$$_ExhibitToJson(_$_Exhibit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'openingTime': instance.openingTime,
      'imageList': instance.imageList,
      'location': instance.location,
      'title': instance.title,
      'userId': instance.userId,
      'userImageUrl': instance.userImageUrl,
      'username': instance.username,
    };
