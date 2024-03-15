import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:entery_mid_level_task/models/user_profile_model.dart';
import 'package:entery_mid_level_task/service/dio_exception.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dio_client.dart';

abstract interface class IAuthService {
  Future<Either<Failure, UserProfileModel>> login(String username, String password);
  Future<Either<Failure, UserProfileModel>> refreshToken();
  Future<Either<Failure, UserProfileModel>> getProfile();
  void signOut();
  Future<void> saveUserModelToHive(UserProfileModel userModel);
  Future<UserProfileModel?> getUserModelFromHive();
}

class AuthService implements IAuthService {
  final DioClient _dioClient;
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferences _sharedPreferences;

  AuthService({
    required DioClient dioClient,
    required FlutterSecureStorage flutterSecureStorage,
    required SharedPreferences sharedPreferences,
  })  : _dioClient = dioClient,
        _sharedPreferences = sharedPreferences,
        _flutterSecureStorage = flutterSecureStorage;

  @override
  Future<Either<Failure, UserProfileModel>> login(String username, String password) async {
    const path = 'auth/login';
    final data = {
      'username': username,
      'password': password,
    };
    try {
      final Response response = await _dioClient.request(
        url: path,
        method: 'POST',
        data: data,
        includeTokenProtection: false,
      );
      if (response.statusCode == 200) {
        await Future.wait([
          _flutterSecureStorage.write(key: 'username', value: username),
          _flutterSecureStorage.write(key: 'password', value: password),
        ]);
        final userProfile = UserProfileModel.fromJson(response.data);
        await saveUserModelToHive(userProfile);
        return Right(userProfile);
      } else {
        return Left(Failure.unknownServerError(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
        Failure.unknownServerError(
          DioExceptions.fromDioError(e).message,
        ),
      );
    } catch (e) {
      return Left(Failure.unknownServerError(e.toString()));
    }
  }

  @override
  void signOut() {
    _flutterSecureStorage.deleteAll();
    _sharedPreferences.clear();
  }

  @override
  Future<Either<Failure, UserProfileModel>> refreshToken() async {
    final storedUsername = await _flutterSecureStorage.read(key: 'username');
    final storedPassword = await _flutterSecureStorage.read(key: 'password');
    if (storedUsername != null && storedPassword != null) {
      try {
        final response = await login(storedUsername, storedPassword);
        return await response.fold(
          (failure) => Left(failure),
          (userProfile) async {
            await _flutterSecureStorage.write(key: 'token', value: userProfile.token);
            await saveUserModelToHive(userProfile);
            return Right(userProfile);
          },
        );
      } catch (e) {
        return Left(Failure.unknownServerError(e.toString()));
      }
    } else {
      return Left(Failure.unknownServerError('Cannot refresh the token'));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> getProfile() async {
    const path = 'auth/me';
    try {
      final response = await _dioClient.request(url: path, method: 'GET');
      if (response.statusCode == 200) {
        return Right(UserProfileModel.fromJson(response.data));
      } else {
        return Left(Failure.unknownServerError(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(
        Failure.unknownServerError(
          DioExceptions.fromDioError(e).message,
        ),
      );
    } catch (e) {
      return Left(Failure.unknownServerError(e.toString()));
    }
  }

  @override
  Future<void> saveUserModelToHive(UserProfileModel userModel) async {
    await Hive.openBox<UserProfileModel>('user_profile');
    final box = Hive.box<UserProfileModel>('user_profile');
    await box.put('user', userModel);
  }

  @override
  Future<UserProfileModel?> getUserModelFromHive() async {
    await Hive.openBox<UserProfileModel>('user_profile');
    final box = Hive.box<UserProfileModel>('user_profile');
    return box.get('user');
  }
}
