import 'package:dio/dio.dart';
import 'package:entery_mid_level_task/service/dio_client.dart';
import 'package:entery_mid_level_task/service/auth/auth_service.dart';
import 'package:entery_mid_level_task/service/hive/local_storage.dart';
import 'package:entery_mid_level_task/service/products/products_service.dart';
import 'package:entery_mid_level_task/service/theme/theme_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
late final String objectBoxDbPath;

class ServiceLocator {
  static final ServiceLocator instance = ServiceLocator._();
  final logger = Logger();

  ServiceLocator._();

  Future<void> init() async {
    logger.i('Service Locator initializing...');
    final sharedPreferences = await SharedPreferences.getInstance();
    const flutterSecureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    getIt.registerLazySingleton(
      () => sharedPreferences,
    );
    getIt.registerLazySingleton(
      () => flutterSecureStorage,
    );
    getIt.registerFactory(
      () => Dio(),
    );
    getIt.registerFactory(
      () => DioClient(
        getService(),
        getService(),
      ),
    );
    getIt.registerFactory<ILocalStorage>(
      () => LocalStorage()..init(),
    );
    getIt.registerFactory(
      () => AuthService(
        sharedPreferences: getService(),
        dioClient: getService(),
        flutterSecureStorage: getService(),
      ),
    );

    getIt.registerFactory<IProductsRepository>(
      () => ProductWebApiService(
        getService(),
      ),
    );

    getIt.registerLazySingleton<IThemeRepository>(
      () => ThemeRepository(
        getService(),
      ),
    );
  }
}

T getService<T extends Object>() => getIt<T>();
