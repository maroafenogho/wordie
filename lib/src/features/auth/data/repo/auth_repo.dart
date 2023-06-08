import 'package:wordie/src/features/auth/data/services/auth_service.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

class AuthRepo {
  AuthRepo({AuthService? service}) : _authService = service ?? AuthService();

  final AuthService _authService;

  Future<User?> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    return await _authService.createUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName);
  }

  Future<User?> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  Future<bool> logout() async {
    return _authService.logout();
  }

  Stream<User?> get currentUser {
    return _authService.currentUser;
  }
}
