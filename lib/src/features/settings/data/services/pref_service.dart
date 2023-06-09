import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/settings/presentation/controllers/settings_controller.dart';

class SettingsService {
  Future<bool> setDisplayType(Ref ref, String displayType) async {
    bool success = false;
    try {
      await ref
          .read(sharedPreferencesProvider)
          .setString('display_type', displayType);
      success = true;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return success;
  }

  String? getDisplayType(Ref ref) {
    return ref.read(sharedPreferencesProvider).getString('display_type');
  }
}
