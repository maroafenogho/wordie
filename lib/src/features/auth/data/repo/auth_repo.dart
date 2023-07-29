import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/services/auth_service.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

class AuthRepo {
  AuthRepo(this._authService);
  final AuthService _authService;

  Future<AppUser?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    return await _authService.createUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Future<AppUser?> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  Future<bool> logout() async {
    return _authService.logout();
  }

  Future<bool> resetPassword(String email) async {
    return _authService.resetPassword(email);
  }

  Stream<AppUser?> get currentUser {
    return _authService.currentUser();
  }
}

final authRepoProvider =
    Provider((ref) => AuthRepo(ref.watch(authServiceProvider)));
