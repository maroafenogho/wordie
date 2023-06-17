import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:wordie/src/features/auth/domain/user.dart';

class AuthService {
  final _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user != null) {
      return User(
        email: user.email!,
        emailVerified: user.emailVerified,
        fullName: user.displayName,
        userId: user.uid,
      );
    } else {
      return null;
    }
  }

  Stream<User?> get currentUser {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!credential.user!.emailVerified) {
        await logout()
            .then((value) => throw Exception('Unverified email address'));
      }
   
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }

  Future<bool> logout() async {
    bool success = false;
    try {
      await _firebaseAuth.signOut();

      success = true;
    } catch (error) {
      log(error.toString());
    }
    return success;
  }

  Future<User?> createUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await credential.user!.updateDisplayName('$firstName $lastName');

      await credential.user!.sendEmailVerification();
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }
}
