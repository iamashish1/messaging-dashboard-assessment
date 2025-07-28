// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_mode_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppThemeModeAdapter extends TypeAdapter<AppThemeMode> {
  @override
  final int typeId = 2;

  @override
  AppThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppThemeMode.light;
      case 1:
        return AppThemeMode.dark;
      default:
        return AppThemeMode.light;
    }
  }

  @override
  void write(BinaryWriter writer, AppThemeMode obj) {
    switch (obj) {
      case AppThemeMode.light:
        writer.writeByte(0);
        break;
      case AppThemeMode.dark:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppThemeModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
