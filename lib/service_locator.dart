import 'package:dio/dio.dart';
import 'package:entery_mid_level_task/service/dio_client.dart';
import 'package:entery_mid_level_task/service/login/login_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
late final String objectBoxDbPath;

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._();

  ServiceLocator._();

  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    );
    getIt.registerLazySingleton(
      () => Dio(),
    );
    getIt.registerFactory(() => LoginService(
          dioClient: DioClient(getService()),
        ));
  }

  T getService<T extends Object>() => getIt<T>();
}
