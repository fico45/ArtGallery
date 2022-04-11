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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Exhibit _$ExhibitFromJson(Map<String, dynamic> json) {
  return _Exhibit.fromJson(json);
}

/// @nodoc
class _$ExhibitTearOff {
  const _$ExhibitTearOff();

  _Exhibit call(
      {String? id,
      required DateTime createdAt,
      required String description,
      required DateTime startDate,
      required DateTime endDate,
      required String openingTime,
      String? exhibitImageUrl,
      required String location,
      required String title,
      required String userId,
      required String userImageUrl,
      required String username}) {
    return _Exhibit(
      id: id,
      createdAt: createdAt,
      description: description,
      startDate: startDate,
      endDate: endDate,
      openingTime: openingTime,
      exhibitImageUrl: exhibitImageUrl,
      location: location,
      title: title,
      userId: userId,
      userImageUrl: userImageUrl,
      username: username,
    );
  }

  Exhibit fromJson(Map<String, Object?> json) {
    return Exhibit.fromJson(json);
  }
}

/// @nodoc
const $Exhibit = _$ExhibitTearOff();

/// @nodoc
mixin _$Exhibit {
  String? get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get openingTime => throw _privateConstructorUsedError;
  String? get exhibitImageUrl => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
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
      DateTime createdAt,
      String description,
      DateTime startDate,
      DateTime endDate,
      String openingTime,
      String? exhibitImageUrl,
      String location,
      String title,
      String userId,
      String userImageUrl,
      String username});
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
    Object? createdAt = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? openingTime = freezed,
    Object? exhibitImageUrl = freezed,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingTime: openingTime == freezed
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as String,
      exhibitImageUrl: exhibitImageUrl == freezed
          ? _value.exhibitImageUrl
          : exhibitImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$ExhibitCopyWith<$Res> implements $ExhibitCopyWith<$Res> {
  factory _$ExhibitCopyWith(_Exhibit value, $Res Function(_Exhibit) then) =
      __$ExhibitCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      DateTime createdAt,
      String description,
      DateTime startDate,
      DateTime endDate,
      String openingTime,
      String? exhibitImageUrl,
      String location,
      String title,
      String userId,
      String userImageUrl,
      String username});
}

/// @nodoc
class __$ExhibitCopyWithImpl<$Res> extends _$ExhibitCopyWithImpl<$Res>
    implements _$ExhibitCopyWith<$Res> {
  __$ExhibitCopyWithImpl(_Exhibit _value, $Res Function(_Exhibit) _then)
      : super(_value, (v) => _then(v as _Exhibit));

  @override
  _Exhibit get _value => super._value as _Exhibit;

  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? openingTime = freezed,
    Object? exhibitImageUrl = freezed,
    Object? location = freezed,
    Object? title = freezed,
    Object? userId = freezed,
    Object? userImageUrl = freezed,
    Object? username = freezed,
  }) {
    return _then(_Exhibit(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: endDate == freezed
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingTime: openingTime == freezed
          ? _value.openingTime
          : openingTime // ignore: cast_nullable_to_non_nullable
              as String,
      exhibitImageUrl: exhibitImageUrl == freezed
          ? _value.exhibitImageUrl
          : exhibitImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_Exhibit extends _Exhibit with DiagnosticableTreeMixin {
  const _$_Exhibit(
      {this.id,
      required this.createdAt,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.openingTime,
      this.exhibitImageUrl,
      required this.location,
      required this.title,
      required this.userId,
      required this.userImageUrl,
      required this.username})
      : super._();

  factory _$_Exhibit.fromJson(Map<String, dynamic> json) =>
      _$$_ExhibitFromJson(json);

  @override
  final String? id;
  @override
  final DateTime createdAt;
  @override
  final String description;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String openingTime;
  @override
  final String? exhibitImageUrl;
  @override
  final String location;
  @override
  final String title;
  @override
  final String userId;
  @override
  final String userImageUrl;
  @override
  final String username;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Exhibit(id: $id, createdAt: $createdAt, description: $description, startDate: $startDate, endDate: $endDate, openingTime: $openingTime, exhibitImageUrl: $exhibitImageUrl, location: $location, title: $title, userId: $userId, userImageUrl: $userImageUrl, username: $username)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Exhibit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('endDate', endDate))
      ..add(DiagnosticsProperty('openingTime', openingTime))
      ..add(DiagnosticsProperty('exhibitImageUrl', exhibitImageUrl))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('userImageUrl', userImageUrl))
      ..add(DiagnosticsProperty('username', username));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Exhibit &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.endDate, endDate) &&
            const DeepCollectionEquality()
                .equals(other.openingTime, openingTime) &&
            const DeepCollectionEquality()
                .equals(other.exhibitImageUrl, exhibitImageUrl) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.userImageUrl, userImageUrl) &&
            const DeepCollectionEquality().equals(other.username, username));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(startDate),
      const DeepCollectionEquality().hash(endDate),
      const DeepCollectionEquality().hash(openingTime),
      const DeepCollectionEquality().hash(exhibitImageUrl),
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(userImageUrl),
      const DeepCollectionEquality().hash(username));

  @JsonKey(ignore: true)
  @override
  _$ExhibitCopyWith<_Exhibit> get copyWith =>
      __$ExhibitCopyWithImpl<_Exhibit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExhibitToJson(this);
  }
}

abstract class _Exhibit extends Exhibit {
  const factory _Exhibit(
      {String? id,
      required DateTime createdAt,
      required String description,
      required DateTime startDate,
      required DateTime endDate,
      required String openingTime,
      String? exhibitImageUrl,
      required String location,
      required String title,
      required String userId,
      required String userImageUrl,
      required String username}) = _$_Exhibit;
  const _Exhibit._() : super._();

  factory _Exhibit.fromJson(Map<String, dynamic> json) = _$_Exhibit.fromJson;

  @override
  String? get id;
  @override
  DateTime get createdAt;
  @override
  String get description;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get openingTime;
  @override
  String? get exhibitImageUrl;
  @override
  String get location;
  @override
  String get title;
  @override
  String get userId;
  @override
  String get userImageUrl;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$ExhibitCopyWith<_Exhibit> get copyWith =>
      throw _privateConstructorUsedError;
}
