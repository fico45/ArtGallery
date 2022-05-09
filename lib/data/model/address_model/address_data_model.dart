import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_data_model.freezed.dart';
part 'address_data_model.g.dart';

@freezed
abstract class AddressData implements _$AddressData {
  const AddressData._();

  const factory AddressData({
    String? street,
    String? city,
    String? country,
  }) = _AddressData;

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);
}
