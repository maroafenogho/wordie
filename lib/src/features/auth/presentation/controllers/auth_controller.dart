import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repo/auth_repo.dart';

final authRepoProvider = Provider((ref) => AuthRepo());

final showPasswordProvider = StateProvider<bool>((ref) => false);
