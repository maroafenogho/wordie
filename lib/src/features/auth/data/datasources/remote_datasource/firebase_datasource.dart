import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:wordie/src/features/auth/domain/entity/user.dart';

class FirebaseDatasource implements AuthDatasource {
  final auth.FirebaseAuth _firebaseAuth;

  FirebaseDatasource(this._firebaseAuth);

  WordieUser? _userFromFirebase(auth.User? user) {
    if (user != null) {
      return WordieUser(
        email: user.email!,
        emailVerified: user.emailVerified,
        fullName: user.displayName,
        userId: user.uid,
      );
    } else {
      return null;
    }
  }

  @override
  Stream<WordieUser?> getUser() {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<WordieUser?> login(String email, String password) async {
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
      // throw WordieException(message: 'Login Error');

      throw Exception(error);
    }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
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
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

final firebaseDatasourceProvider = Provider<AuthDatasource>(
  (ref) => FirebaseDatasource(ref.watch(fbAuthProvider)),
);

final fbAuthProvider = Provider((ref) => auth.FirebaseAuth.instance);
