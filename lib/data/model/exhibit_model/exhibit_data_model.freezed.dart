// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exhibit_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Exhibit _$ExhibitFromJson(Map<String, dynamic> json) {
  return _Exhibit.fromJson(json);
}

/// @nodoc
mixin _$Exhibit {
  String? get id => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startDateTime => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<String> get imageList => throw _privateConstructorUsedError;
  AddressData get location => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userImageUrl => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExhibitCopyWith<Exhibit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExhibitCopyWith<$Res> {
  factory $ExhibitCopyWith(Exhibit value, $Res Function(Exhibit) then) =
      _$ExhibitCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      double lat,
      double lng,
      DateTime createdAt,
      String description,
      DateTime startDateTime,
      DateTime endDate,
      List<String> imageList,
      AddressData location,
      String title,
      String userId,
      String userImageUrl,
      String username});

  $AddressDataCopyWith<$Res> get location;
}

/// @nodoc
class _$ExhibitCopyWithImpl<$Res> implements $ExhibitCopyWith<$Res> {
  _$ExhibitCopyWithImpl(this._value, this._then);

  final Exhibit _value;
  // ignore: unused_field
  final $Res Function(Exhibit) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? createdAt = freezed,
    Object? description = freezed,
    Object? startDateTime = freezed,
    Object? endDate = freezed,
    Object? imageList = freezed,
    Object? location = freezed,
    Object? title = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? username = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDateTime: startDateTime == freezed
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageList: imageList == freezed
          ? _value.imageList
          : imageList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AddressData,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: userImageUrl == freezed
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $AddressDataCopyWith<$Res> get location {
    return $AddressDataCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc
abstract class _$$_ExhibitCopyWith<$Res> implements $ExhibitCopyWith<$Res> {
  factory _$$_ExhibitCopyWith(
          _$_Exhibit value, $Res Function(_$_Exhibit) then) =
      __$$_ExhibitCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      double lat,
      double lng,
      DateTime createdAt,
      String description,
      DateTime startDateTime,
      DateTime endDate,
      List<String> imageList,
      AddressData location,
      String title,
      String userId,
      String userImageUrl,
      String username});

  @override
  $AddressDataCopyWith<$Res> get location;
}

/// @nodoc
class __$$_ExhibitCopyWithImpl<$Res> extends _$ExhibitCopyWithImpl<$Res>
    implements _$$_ExhibitCopyWith<$Res> {
  __$$_ExhibitCopyWithImpl(_$_Exhibit _value, $Res Function(_$_Exhibit) _then)
      : super(_value, (v) => _then(v as _$_Exhibit));

  @override
  _$_Exhibit get _value => super._value as _$_Exhibit;

  @override
  $Res call({
    Object? id = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? createdAt = freezed,
    Object? description = freezed,
    Object? startDateTime = freezed,
    Object? endDate = freezed,
    Object? imageList = freezed,
    Object? location = freezed,
    Object? title = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? username = freezed,
  }) {
    return _then(_$_Exhibit(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDateTime: startDateTime == freezed
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageList: imageList == freezed
          ? _value._imageList
          : imageList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AddressData,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: userImageUrl == freezed
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Exhibit extends _Exhibit {
  const _$_Exhibit(
      {this.id,
      required this.lat,
      required this.lng,
      required this.createdAt,
      required this.description,
      required this.startDateTime,
      required this.endDate,
      required final List<String> imageList,
      required this.location,
      required this.title,
      required this.userId,
      required this.userImageUrl,
      required this.username})
      : _imageList = imageList,
        super._();

  factory _$_Exhibit.fromJson(Map<String, dynamic> json) =>
      _$$_ExhibitFromJson(json);

  @override
  final String? id;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final DateTime createdAt;
  @override
  final String description;
  @override
  final DateTime startDateTime;
  @override
  final DateTime endDate;
  final List<String> _imageList;
  @override
  List<String> get imageList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageList);
  }

  @override
  final AddressData location;
  @override
  final String title;
  @override
  final String userId;
  @override
  final String userImageUrl;
  @override
  final String username;

  @override
  String toString() {
    return 'Exhibit(id: $id, lat: $lat, lng: $lng, createdAt: $createdAt, description: $description, startDateTime: $startDateTime, endDate: $endDate, imageList: $imageList, location: $location, title: $title, userId: $userId, userImageUrl: $userImageUrl, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Exhibit &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.lat, lat) &&
            const DeepCollectionEquality().equals(other.lng, lng) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.startDateTime, startDateTime) &&
            const DeepCollectionEquality().equals(other.endDate, endDate) &&
            const DeepCollectionEquality()
                .equals(other._imageList, _imageList) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.userImageUrl, userImageUrl) &&
            const DeepCollectionEquality().equals(other.username, username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(lat),
      const DeepCollectionEquality().hash(lng),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(startDateTime),
      const DeepCollectionEquality().hash(endDate),
      const DeepCollectionEquality().hash(_imageList),
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(userImageUrl),
      const DeepCollectionEquality().hash(username));

  @JsonKey(ignore: true)
  @override
  _$$_ExhibitCopyWith<_$_Exhibit> get copyWith =>
      __$$_ExhibitCopyWithImpl<_$_Exhibit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExhibitToJson(this);
  }
}

abstract class _Exhibit extends Exhibit {
  const factory _Exhibit(
      {final String? id,
      required final double lat,
      required final double lng,
      required final DateTime createdAt,
      required final String description,
      required final DateTime startDateTime,
      required final DateTime endDate,
      required final List<String> imageList,
      required final AddressData location,
      required final String title,
      required final String userId,
      required final String userImageUrl,
      required final String username}) = _$_Exhibit;
  const _Exhibit._() : super._();

  factory _Exhibit.fromJson(Map<String, dynamic> json) = _$_Exhibit.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  double get lat => throw _privateConstructorUsedError;
  @override
  double get lng => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  DateTime get startDateTime => throw _privateConstructorUsedError;
  @override
  DateTime get endDate => throw _privateConstructorUsedError;
  @override
  List<String> get imageList => throw _privateConstructorUsedError;
  @override
  AddressData get location => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  String get userImageUrl => throw _privateConstructorUsedError;
  @override
  String get username => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ExhibitCopyWith<_$_Exhibit> get copyWith =>
      throw _privateConstructorUsedError;
}
