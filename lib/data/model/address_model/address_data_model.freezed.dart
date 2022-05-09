// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'address_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddressData _$AddressDataFromJson(Map<String, dynamic> json) {
  return _AddressData.fromJson(json);
}

/// @nodoc
class _$AddressDataTearOff {
  const _$AddressDataTearOff();

  _AddressData call({String? street, String? city, String? country}) {
    return _AddressData(
      street: street,
      city: city,
      country: country,
    );
  }

  AddressData fromJson(Map<String, Object?> json) {
    return AddressData.fromJson(json);
  }
}

/// @nodoc
const $AddressData = _$AddressDataTearOff();

/// @nodoc
mixin _$AddressData {
  String? get street => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressDataCopyWith<AddressData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressDataCopyWith<$Res> {
  factory $AddressDataCopyWith(
          AddressData value, $Res Function(AddressData) then) =
      _$AddressDataCopyWithImpl<$Res>;
  $Res call({String? street, String? city, String? country});
}

/// @nodoc
class _$AddressDataCopyWithImpl<$Res> implements $AddressDataCopyWith<$Res> {
  _$AddressDataCopyWithImpl(this._value, this._then);

  final AddressData _value;
  // ignore: unused_field
  final $Res Function(AddressData) _then;

  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? country = freezed,
  }) {
    return _then(_value.copyWith(
      street: street == freezed
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$AddressDataCopyWith<$Res>
    implements $AddressDataCopyWith<$Res> {
  factory _$AddressDataCopyWith(
          _AddressData value, $Res Function(_AddressData) then) =
      __$AddressDataCopyWithImpl<$Res>;
  @override
  $Res call({String? street, String? city, String? country});
}

/// @nodoc
class __$AddressDataCopyWithImpl<$Res> extends _$AddressDataCopyWithImpl<$Res>
    implements _$AddressDataCopyWith<$Res> {
  __$AddressDataCopyWithImpl(
      _AddressData _value, $Res Function(_AddressData) _then)
      : super(_value, (v) => _then(v as _AddressData));

  @override
  _AddressData get _value => super._value as _AddressData;

  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? country = freezed,
  }) {
    return _then(_AddressData(
      street: street == freezed
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddressData extends _AddressData {
  const _$_AddressData({this.street, this.city, this.country}) : super._();

  factory _$_AddressData.fromJson(Map<String, dynamic> json) =>
      _$$_AddressDataFromJson(json);

  @override
  final String? street;
  @override
  final String? city;
  @override
  final String? country;

  @override
  String toString() {
    return 'AddressData(street: $street, city: $city, country: $country)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddressData &&
            const DeepCollectionEquality().equals(other.street, street) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.country, country));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(street),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(country));

  @JsonKey(ignore: true)
  @override
  _$AddressDataCopyWith<_AddressData> get copyWith =>
      __$AddressDataCopyWithImpl<_AddressData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressDataToJson(this);
  }
}

abstract class _AddressData extends AddressData {
  const factory _AddressData({String? street, String? city, String? country}) =
      _$_AddressData;
  const _AddressData._() : super._();

  factory _AddressData.fromJson(Map<String, dynamic> json) =
      _$_AddressData.fromJson;

  @override
  String? get street;
  @override
  String? get city;
  @override
  String? get country;
  @override
  @JsonKey(ignore: true)
  _$AddressDataCopyWith<_AddressData> get copyWith =>
      throw _privateConstructorUsedError;
}
