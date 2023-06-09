import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordie/src/features/settings/data/services/pref_service.dart';

class SettingsRepo {
  final Ref ref;
  final SettingsService _settingsService;

  SettingsRepo({required this.ref, SettingsService? service})
      : _settingsService = service ?? SettingsService();

  Future<bool> setDisplayType(String displayType) async {
    return await _settingsService.setDisplayType(ref, displayType);
  }

  String? getDisplayType() {
    return _settingsService.getDisplayType(ref);
  }
}
