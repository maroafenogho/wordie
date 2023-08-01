import 'package:wordie/src/common/app_ecxceptions/exceptions.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';

abstract class UserRepository {
  Future<WordieUser?> login(String email, String password);
  Stream<WordieUser?> getUser();
  Future<WordieUser?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<bool> logout();
  Future<bool> resetPassword(String email);
}
