import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:wordie/src/features/auth/data/datasources/remote_datasource/firebase_datasource.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';
import 'package:wordie/src/features/auth/domain/repository/user_repo.dart';

class UserRepositoryImplementation implements UserRepository {
  final AuthDatasource _datasource;

  UserRepositoryImplementation(this._datasource);

  @override
  Stream<WordieUser?> getUser() {
    return _datasource.getUser();
  }

  @override
  Future<WordieUser?> login(String email, String password) {
    return _datasource.login(email, password);
  }

  @override
  Future<bool> logout() {
    return _datasource.logout();
  }

  @override
  Future<bool> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<WordieUser?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) {
    return _datasource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName);
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) =>
    UserRepositoryImplementation(ref.watch(firebaseDatasourceProvider)));
