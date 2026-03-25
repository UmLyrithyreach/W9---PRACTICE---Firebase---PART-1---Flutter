import 'package:flutter/widgets.dart';

import '../../data/repositories/settings/app_settings_repository.dart';
import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  final AppSettingsRepository repository;

  late AppSettings _appSettings;

  AppSettingsState({required this.repository}) {
    // Initialize with default immediately
    _appSettings = AppSettings(themeColor: ThemeColor.blue);
    _init();
  }

  Future<void> _init() async {
    try {
      _appSettings = await repository.load();
    } catch (e) {
      print('Error loading app settings: $e');
      // Keep default settings on error
      _appSettings = AppSettings(themeColor: ThemeColor.blue);
    } finally {
      notifyListeners();
    }
  }

  ThemeColor get theme => _appSettings.themeColor;

  Future<void> changeTheme(ThemeColor themeColor) async {
    _appSettings = _appSettings.copyWith(themeColor: themeColor);
    await repository.save(_appSettings);
    notifyListeners();
  }
}
