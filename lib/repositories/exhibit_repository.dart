import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/data/providers/general_providers.dart';
import 'package:artgallery/repositories/custom_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseExhibitRepository {
  Future<List<Exhibit>> retrieveAllExhibits({required String userId});
  Future<List<Exhibit>> retrieveCurrentUserExhibits({required String userId});
  Future<String> createExhibit({required Exhibit exhibit});
  Future<void> updateExhibit(
      {required String userId, required Exhibit exhibit});
  Future<void> deleteExhibit(
      {required String userId,
      required String exhibitId,
      required List<String> imagesToDelete});
}

final exhibitRepositoryProvider =
    Provider<ExhibitRepository>((ref) => ExhibitRepository(ref.read));

class ExhibitRepository implements BaseExhibitRepository {
  final Reader _read;

  const ExhibitRepository(this._read);

  @override
  Future<List<Exhibit>> retrieveAllExhibits({required String userId}) async {
    try {
      final snap = await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .orderBy('startDateTime')
          .get();
      return snap.docs.map((doc) => Exhibit.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Exhibit>> retrieveCurrentUserExhibits(
      {required String userId}) async {
    try {
      final snap = await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .orderBy('startDateTime')
          .where('userId', isEqualTo: userId)
          .get();
      return snap.docs.map((doc) => Exhibit.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<String> createExhibit({
    required Exhibit exhibit,
  }) async {
    try {
      final docRef = await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .add(exhibit.toDocument());
      /*      exhibit.id = docRef.id;
      _read(firebaseFirstoreProvider)
          .collection("exhibits")
          .doc(docRef.id)
          .update(exhibit.toDocument()); */
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
          //exhibit.id or exhibit document ID?
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
    required List<String> imagesToDelete,
  }) async {
    try {
      imagesToDelete.forEach(
          (element) => FirebaseStorage.instance.refFromURL(element).delete());
      await _read(firebaseFirstoreProvider)
          .collection('exhibits')
          .doc(exhibitId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
