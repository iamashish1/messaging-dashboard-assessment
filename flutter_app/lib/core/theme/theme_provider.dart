import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_constants.dart';
import 'package:flutter_app/core/theme/app_theme_mode_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  late final Box _box;

  AppThemeMode _mode = AppThemeMode.light;
  AppThemeMode get mode => _mode;

  ThemeMode get materialTheme =>
      _mode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _init();
  }

  void _init() async {
    _box = await Hive.openBox(AppConstants.hiveThemeBox);
    _mode = AppThemeMode.fromName(
      _box.get(
        AppConstants.hiveThemeKey,
        defaultValue: AppThemeMode.light.name,
      ),
    );
    notifyListeners();
  }

  void toggleTheme() {
    _mode =
        _mode == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    _box.put(AppConstants.hiveThemeKey, _mode.name);
    notifyListeners();
  }
}
