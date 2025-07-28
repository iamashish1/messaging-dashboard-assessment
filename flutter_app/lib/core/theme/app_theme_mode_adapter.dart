import 'package:hive_flutter/hive_flutter.dart';

part 'app_theme_mode_adapter.g.dart';

@HiveType(typeId: 2)
enum AppThemeMode {
  @HiveField(0)
  light,
  @HiveField(1)
  dark;

  String get name => toString().split('.').last;

  static AppThemeMode fromName(String name) {
    return AppThemeMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => AppThemeMode.light,
    );
  }
}
