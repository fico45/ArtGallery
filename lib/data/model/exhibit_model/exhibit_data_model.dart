import 'package:artgallery/data/model/address_model/address_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exhibit_data_model.freezed.dart';
part 'exhibit_data_model.g.dart';

@freezed
abstract class Exhibit implements _$Exhibit {
  const Exhibit._();

  const factory Exhibit({
    String? id,
    required double lat,
    required double lng,
    required DateTime createdAt,
    required String description,
    required DateTime startDateTime,
    required DateTime endDate,
    required List<String> imageList,
    required AddressData location,
    required String title,
    required String userId,
    required String userImageUrl,
    required String username,
  }) = _Exhibit;

  factory Exhibit.fromJson(Map<String, dynamic> json) =>
      _$ExhibitFromJson(json);

  factory Exhibit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Exhibit.fromJson(data).copyWith(id: doc.id);
  }
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
