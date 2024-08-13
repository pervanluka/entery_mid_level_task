import 'package:entery_mid_level_task/models/theme_entity/theme_mode_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IThemeRepository {
  Future<void> saveThemeMode(ThemeModeEntity themeMode);
  Future<ThemeModeEntity> getThemeMode();
}

class ThemeRepository implements IThemeRepository {
  final SharedPreferences sharedPreferences;

  ThemeRepository(this.sharedPreferences);

  @override
  Future<void> saveThemeMode(ThemeModeEntity themeMode) async {
    await sharedPreferences.setString('theme_mode', themeMode.toString());
  }

  @override
  Future<ThemeModeEntity> getThemeMode() async {
    final themeMode = sharedPreferences.getString('theme_mode');

    switch (themeMode) {
      case 'ThemeModeEntity.dark':
        return ThemeModeEntity.dark;
      case 'ThemeModeEntity.light':
        return ThemeModeEntity.light;
      default:
        return ThemeModeEntity.system;
    }
  }
}
