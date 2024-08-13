import 'package:entery_mid_level_task/models/theme_entity/theme_mode_entity.dart';
import 'package:entery_mid_level_task/service/theme/theme_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeModeEntity> {
  final IThemeRepository _themeRepo;

  ThemeCubit({
    required IThemeRepository themeRepo,
  })  : _themeRepo = themeRepo,
        super(ThemeModeEntity.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final themeMode = await _themeRepo.getThemeMode();
    emit(themeMode);
  }

  Future<void> changeThemeMode(ThemeModeEntity themeMode) async {
    await _themeRepo.saveThemeMode(themeMode);
    emit(themeMode);
  }
}
