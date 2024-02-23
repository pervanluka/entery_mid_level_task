import 'package:entery_mid_level_task/feature/root_app/cubit/root_app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootAppCubit extends Cubit<RootAppState> {
  final SharedPreferences _sharedPreferences;
  RootAppCubit({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(RootAppInitial());

  void checkIsUserAlreadyLogged() {
    final read = _sharedPreferences.getBool('shouldStayLogged') ?? false;
    switch (read) {
      case true:
        emit(RootAppStayLogged());
      default:
        emit(RootAppLoggedOut());
    }
  }
}
