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
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      imageList:
          (json['imageList'] as List<dynamic>).map((e) => e as String).toList(),
      location: AddressData.fromJson(
          Map<String, dynamic>.from(json['location'] as Map)),
      title: json['title'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_ExhibitToJson(_$_Exhibit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'imageList': instance.imageList,
      'location': instance.location.toJson(),
      'title': instance.title,
      'userId': instance.userId,
      'username': instance.username,
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
    };
