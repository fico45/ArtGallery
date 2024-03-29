import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/model/address_model/address_data_model.dart';
import 'package:artgallery/data/model/exhibit_model/exhibit_data_model.dart';
import 'package:artgallery/repositories/custom_exception.dart';
import 'package:artgallery/repositories/exhibit_repository.dart';
import 'package:artgallery/view/widgets/exhibit/new_exhibit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/comment_model/comment_data_model.dart';

final exhibitListExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final exhibitListControllerProvider =
    StateNotifierProvider<ExhibitListController, AsyncValue<List<Exhibit>>>(
        (ref) {
  final user = ref.watch(authControllerProvider);
  return ExhibitListController(ref.read, user?.uid);
});

class ExhibitListController extends StateNotifier<AsyncValue<List<Exhibit>>> {
  final Reader _read;
  final String? _userId;

  ExhibitListController(this._read, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveAllExhibits();
    }
  }

  Future<void> retrieveAllExhibits() async {
    try {
      final exhibits = await _read(exhibitRepositoryProvider)
          .retrieveAllExhibits(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(exhibits);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> retrieveCurrentUserExhibits() async {
    try {
      final exhibits = await _read(exhibitRepositoryProvider)
          .retrieveCurrentUserExhibits(userId: _userId!);
      if (mounted) {
        state = AsyncValue.data(exhibits);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<void> addExhibit({
    String? id,
    required double lat,
    required double lng,
    required DateTime createdAt,
    required String description,
    required DateTime startDateTime,
    required DateTime endDate,
    required AddressData location,
    required String title,
    required String userId,
    required List<String> imageList,
    required String username,
  }) async {
    try {
      final exhibit = Exhibit(
        lat: lat,
        lng: lng,
        createdAt: createdAt,
        description: description,
        startDateTime: startDateTime,
        endDate: endDate,
        location: location,
        title: title,
        userId: userId,
        imageList: imageList,
        username: username,
      );
      final exhibitId = await _read(exhibitRepositoryProvider).createExhibit(
        exhibit: exhibit,
      );
      state.whenData((exhibits) => state =
          AsyncValue.data(exhibits..add(exhibit.copyWith(id: exhibitId))));
    } on CustomException catch (e) {
      _read(exhibitListExceptionProvider.notifier).state = e;
    }
  }

  Future<void> updateExhibit({required Exhibit updatedExhibit}) async {
    try {
      await _read(exhibitRepositoryProvider)
          .updateExhibit(userId: _userId!, exhibit: updatedExhibit);
      state.whenData((exhibits) => state = AsyncValue.data([
            for (final item in exhibits)
              if (item.id == updatedExhibit.id) updatedExhibit else item
          ]));
    } on CustomException catch (e) {
      _read(exhibitListExceptionProvider.notifier).state = e;
    }
  }

  Future<void> deleteExhibit({required Exhibit exhibit}) async {
    try {
      await _read(exhibitRepositoryProvider).deleteExhibit(
          userId: _userId!,
          exhibitId: exhibit.id!,
          imagesToDelete: exhibit.imageList);
      state.whenData((items) => state = AsyncValue.data(
          items..removeWhere((element) => element.id == exhibit.id)));
    } on CustomException catch (e) {
      _read(exhibitListExceptionProvider.notifier).state = e;
    }
  }

  Future<Exhibit> postExhibitComment(
      {required Comment comment, required Exhibit exhibit}) async {
    List<Comment> newCommentList =
        exhibit.comments == null ? [] : exhibit.comments!.toList();
    newCommentList..add(comment);
    Exhibit updatedExhibit = Exhibit(
        id: exhibit.id,
        lat: exhibit.lat,
        lng: exhibit.lng,
        createdAt: exhibit.createdAt,
        description: exhibit.description,
        startDateTime: exhibit.startDateTime,
        endDate: exhibit.endDate,
        imageList: exhibit.imageList,
        location: exhibit.location,
        title: exhibit.title,
        userId: exhibit.userId,
        username: exhibit.username,
        comments: newCommentList);
    try {
      await _read(exhibitRepositoryProvider).postExhibitComment(
        comment: comment,
        exhibitId: exhibit.id!,
      );

      state.whenData((exhibits) => state = AsyncValue.data([
            for (final item in exhibits)
              if (item.id == exhibit.id) updatedExhibit else item
          ]));
      return updatedExhibit;
    } on CustomException catch (e) {
      _read(exhibitListExceptionProvider.notifier).state = e;
      return exhibit;
    }
  }
}
