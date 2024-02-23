import 'package:entery_mid_level_task/feature/login/cubit/login_state.dart';
import 'package:entery_mid_level_task/service/login/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService _loginService;
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferences _sharedPreferences;
  LoginCubit({
    required LoginService loginService,
    required FlutterSecureStorage flutterSecureStorage,
    required SharedPreferences sharedPreferences,
  })  : _loginService = loginService,
        _flutterSecureStorage = flutterSecureStorage,
        _sharedPreferences = sharedPreferences,
        super(LoginInitial());

  final logger = Logger();

  Future<void> login(String username, String password) async {
    final response = await _loginService.login(username, password);
    response.fold(
      (l) {
        logger.e(l.description);
        emit(
          LoginFailure(
            failure: l,
          ),
        );
        emit(LoggedOutState());
      },
      (r) {
        Future.wait([
          _flutterSecureStorage.write(key: 'token', value: r.token),
          _sharedPreferences.setBool('shouldStayLogged', true),
        ]);
        emit(LoggedInState(userProfileModel: r));
      },
    );
  }
}
