import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repo/auth_repo.dart';

final authRepoProvider = Provider((ref) => AuthRepo(ref: ref));

final fbAuthProvider = Provider((ref) => FirebaseAuth.instance);

final showPasswordProvider = StateProvider<bool>((ref) => false);
