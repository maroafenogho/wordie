import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  AppUser? _userFromFirebase(auth.User? user) {
    if (user != null) {
      return AppUser(
        email: user.email!,
        emailVerified: user.emailVerified,
        fullName: user.displayName,
        userId: user.uid,
      );
    } else {
      return null;
    }
  }

  Stream<AppUser?> currentUser() {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<AppUser?> login(
    String email,
    String password,
  ) async {
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

  Future<bool> resetPassword(String email) async {
    bool success = false;
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      success = true;
    } catch (error) {
      log(error.toString());
      throw Exception(error);
    }
    return success;
  }

  Future<AppUser?> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
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

final authServiceProvider = Provider(
  (ref) => AuthService(ref.watch(fbAuthProvider)),
);

final fbAuthProvider = Provider((ref) => auth.FirebaseAuth.instance);
