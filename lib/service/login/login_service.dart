import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:entery_mid_level_task/models/user_profile_model.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:logger/logger.dart';
import '../dio_client.dart';

class LoginService {
  final DioClient dioClient;

  LoginService({required this.dioClient});

  Future<Either<Failure, UserProfileModel>> login(String username, String password) async {
    const path = 'auth/login';
    final data = FormData.fromMap({
      'username': username,
      'password': password,
      // 'expiresInMins': 10, // optional
    });
    try {
      final Response response = await dioClient.request(path, 'POST', data);
      if (response.statusCode == 200) {
        return Right(UserProfileModel.fromJson(response.data));
      } else {
        return Left(response.data['message']);
      }
    } catch (e) {
      final logger = Logger();
      logger.e(e.toString());
      return Left(Failure.unknownServerError(e.toString()));
    }
  }
}
