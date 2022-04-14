import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/data/providers/general_providers.dart';
import 'package:artgallery/repositories/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseExhibitRepository {
  Future<List<Exhibit>> retrieveExhibits({required String userId});

  Future<String> createExhibit(
      {required String userId, required Exhibit exhibit});
  Future<void> updateExhibit(
      {required String userId, required Exhibit exhibit});
  Future<void> deleteExhibit(
      {required String userId, required String exhibitId});
}

final exhibitRepositoryProvider =
    Provider<ExhibitRepository>((ref) => ExhibitRepository(ref.read));

class ExhibitRepository implements BaseExhibitRepository {
  final Reader _read;

  const ExhibitRepository(this._read);

  @override
  Future<List<Exhibit>> retrieveExhibits({required String userId}) async {
    try {
      final snap = await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .orderBy('startDate')
          .get();
      return snap.docs.map((doc) => Exhibit.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createExhibit({
    required String userId,
    required Exhibit exhibit,
  }) async {
    try {
      final docRef = await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .add(exhibit.toDocument());

      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateExhibit(
      {required String userId, required Exhibit exhibit}) async {
    try {
      await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .doc(exhibit.id)
          .update(exhibit.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteExhibit({
    required String userId,
    required String exhibitId,
  }) async {
    try {
      await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .doc(exhibitId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
