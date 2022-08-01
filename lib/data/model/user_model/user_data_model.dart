import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

DateTime _sendAtFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

@freezed
abstract class UserModel implements _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String email,
    required String image_url,
    required String username,
    required String firstName,
    required String lastName,
    required bool reviewable,
    @JsonKey(name: 'createdAt', fromJson: _sendAtFromJson)
        required DateTime createdAt,
    required String bio,
    required List<String> favorites,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }
  Map<String, dynamic> toDocument() => toJson();
}
