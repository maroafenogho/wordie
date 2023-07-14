import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordie/src/features/settings/data/repo/pref_repo.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final displayTypeProvider = StateProvider(
  (ref) => ref.watch(settingsRepoProvider).getDisplayType() ?? 'list',
);
final settingsRepoProvider = Provider(
  (ref) => SettingsRepo(ref: ref),
);
final updateDisplayTypeProvider =
    AsyncNotifierProvider<AsyncDisplayTypeNotifier, bool>(
  () => AsyncDisplayTypeNotifier(),
);

class AsyncDisplayTypeNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<bool> setDisplayType(String displayType) async {
    bool success = false;
    state = await AsyncValue.guard(() async {
      success =
          await ref.watch(settingsRepoProvider).setDisplayType(displayType);
      return success;
    });
    return success;
  }
}
