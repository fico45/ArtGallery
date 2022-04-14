/* import 'package:artgallery/data/model/user_model/user_data_model.dart';
import 'package:artgallery/data/providers/general_providers.dart';
import 'package:artgallery/repositories/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseUserModelRepository {
  Future<UserModel> retrieveUser({required String userId});
  Future<UserModel> createUser({required userId, required UserModel newUser});
  Future<void> updateUser({required userId, required UserModel newUser});
  Future<void> deleteUser({required userId});
}

final userModelRepositoryProvider =
    Provider<UserModelRepository>((ref) => UserModelRepository(ref.read));

class UserModelRepository implements BaseUserModelRepository {
  final Reader _read;

  const UserModelRepository(this._read);

  @override
  Future<UserModel> createUser({required userId, required UserModel newUser}) async {
    try{
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(File(image!.path));
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
    }on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
    
  }

  @override
  Future<void> deleteUser({required userId}) async {
    try{
      await _read(firebaseFirstoreProvider).collection('users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
    
  }

  @override
  Future<UserModel> retrieveUser({required String userId}) {
    // TODO: implement retrieveUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required userId, required UserModel newUser}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
 */