import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/repo/user_repo_iml.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';
import 'package:wordie/src/features/auth/domain/repository/user_repo.dart';

class AuthUsecase {
  final UserRepository _userRepository;

  AuthUsecase(this._userRepository);

  Future<WordieUser?> executeSignUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    return await _userRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName);
  }

  Future<WordieUser?> executeLogin(String email, String password) async {
    return await _userRepository.login(email, password);
  }

  Future<bool> executePasswordReset(String email) async {
    return _userRepository.resetPassword(email);
  }

  Stream<WordieUser?> executeGetUser() {
    return _userRepository.getUser();
  }

  Future<bool> executeLogout() async {
    return await _userRepository.logout();
  }
}

final authUsecaseProvider =
    Provider((ref) => AuthUsecase(ref.read(userRepositoryProvider)));
