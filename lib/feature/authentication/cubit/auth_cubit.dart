import 'package:entery_mid_level_task/feature/authentication/cubit/auth_state.dart';
import 'package:entery_mid_level_task/service/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _loginService;
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferences _sharedPreferences;
  AuthCubit({
    required AuthService loginService,
    required FlutterSecureStorage flutterSecureStorage,
    required SharedPreferences sharedPreferences,
  })  : _loginService = loginService,
        _flutterSecureStorage = flutterSecureStorage,
        _sharedPreferences = sharedPreferences,
        super(AuthInitial());

  final logger = Logger();

  Future<void> login(String username, String password) async {
    emit(Authenticating());
    final response = await _loginService.login(username, password);
    response.fold(
      (l) {
        logger.e(l.description);
        emit(
          AuthenticateFailure(
            failure: l,
          ),
        );
        emit(Unauthenticated());
      },
      (r) {
        Future.wait([
          _flutterSecureStorage.write(key: 'token', value: r.token),
          _sharedPreferences.setBool('shouldStayLogged', true),
        ]);
        logger.i(r.token);
        emit(Authenticated(userProfileModel: r));
      },
    );
  }

  void signOut() {
    _flutterSecureStorage.deleteAll();
    _sharedPreferences.clear();
    emit(Unauthenticated());
  }
}
