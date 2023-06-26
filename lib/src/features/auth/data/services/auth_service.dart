import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/auth/domain/user.dart';
import 'package:wordie/src/features/auth/presentation/controllers/auth_controller.dart';

class AuthService {
  // final _firebaseAuth = auth.FirebaseAuth.instance;

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

  Stream<User?> currentUser(Ref ref) {
    return ref.watch(fbAuthProvider).authStateChanges().map(_userFromFirebase);
  }

  Future<User?> login(String email, String password, Ref ref) async {
    try {
      final credential = await ref
          .watch(fbAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      if (!credential.user!.emailVerified) {
        await logout(ref)
            .then((value) => throw Exception('Unverified email address'));
      }

      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }

  Future<bool> logout(Ref ref) async {
    bool success = false;
    try {
      await ref.watch(fbAuthProvider).signOut();

      success = true;
    } catch (error) {
      log(error.toString());
    }
    return success;
  }

  Future<bool> resetPassword(Ref ref, String email) async {
    bool success = false;
    try {
      await ref.watch(fbAuthProvider).sendPasswordResetEmail(email: email);
      success = true;
    } catch (error) {
      log(error.toString());
      throw Exception(error);
    }
    return success;
  }

  Future<User?> createUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required Ref ref}) async {
    try {
      final credential = await ref
          .watch(fbAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);

      await credential.user!.updateDisplayName('$firstName $lastName');

      await credential.user!.sendEmailVerification();
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (error) {
      log(error.toString());
      throw Exception(error);
    }
  }
}
