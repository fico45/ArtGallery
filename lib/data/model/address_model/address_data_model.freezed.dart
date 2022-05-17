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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddressData _$AddressDataFromJson(Map<String, dynamic> json) {
  return _AddressData.fromJson(json);
}

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
abstract class _$$_AddressDataCopyWith<$Res>
    implements $AddressDataCopyWith<$Res> {
  factory _$$_AddressDataCopyWith(
          _$_AddressData value, $Res Function(_$_AddressData) then) =
      __$$_AddressDataCopyWithImpl<$Res>;
  @override
  $Res call({String? street, String? city, String? country});
}

/// @nodoc
class __$$_AddressDataCopyWithImpl<$Res> extends _$AddressDataCopyWithImpl<$Res>
    implements _$$_AddressDataCopyWith<$Res> {
  __$$_AddressDataCopyWithImpl(
      _$_AddressData _value, $Res Function(_$_AddressData) _then)
      : super(_value, (v) => _then(v as _$_AddressData));

  @override
  _$_AddressData get _value => super._value as _$_AddressData;

  @override
  $Res call({
    Object? street = freezed,
    Object? city = freezed,
    Object? country = freezed,
  }) {
    return _then(_$_AddressData(
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
            other is _$_AddressData &&
            const DeepCollectionEquality().equals(other.street, street) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.country, country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(street),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(country));

  @JsonKey(ignore: true)
  @override
  _$$_AddressDataCopyWith<_$_AddressData> get copyWith =>
      __$$_AddressDataCopyWithImpl<_$_AddressData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressDataToJson(this);
  }
}

abstract class _AddressData extends AddressData {
  const factory _AddressData(
      {final String? street,
      final String? city,
      final String? country}) = _$_AddressData;
  const _AddressData._() : super._();

  factory _AddressData.fromJson(Map<String, dynamic> json) =
      _$_AddressData.fromJson;

  @override
  String? get street => throw _privateConstructorUsedError;
  @override
  String? get city => throw _privateConstructorUsedError;
  @override
  String? get country => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AddressDataCopyWith<_$_AddressData> get copyWith =>
      throw _privateConstructorUsedError;
}
