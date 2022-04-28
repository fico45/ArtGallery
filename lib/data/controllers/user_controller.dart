import 'package:artgallery/data/controllers/auth_controller.dart';
import 'package:artgallery/data/model/user_model/user_data_model.dart';
import 'package:artgallery/repositories/custom_exception.dart';
import 'package:artgallery/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userExceptionController = StateProvider<CustomException?>((_) => null);

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<UserModel>>((ref) {
  final user = ref.watch(authControllerProvider);
  return UserController(ref.read, user?.uid);
});

final getUserProvider = StateNotifierProvider.autoDispose
    .family<UserController, AsyncValue<UserModel>, String>((ref, userId) {
  return UserController(ref.read, userId);
});

class UserController extends StateNotifier<AsyncValue<UserModel>> {
  final Reader _read;
  final String? _userId;

  UserController(
    this._read,
    this._userId,
  ) : super(const AsyncValue.loading()) {
    if (_userId != null) {
      retrieveUserData(_userId);
    }
  }

  Future<void> retrieveUserData(userId) async {
    AsyncValue.loading();
    try {
      final user =
          await _read(userModelRepositoryProvider).retrieveUser(userId: userId);
      if (mounted) {
        state = AsyncValue.data(user);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }
}
