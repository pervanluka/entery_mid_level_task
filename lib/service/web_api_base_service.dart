import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:entery_mid_level_task/service/dio_exception.dart';

import 'dio_client.dart';
import 'failure/failure.dart';

abstract class WebApiServiceBase {
  final DioClient _dioClient;

  WebApiServiceBase(this._dioClient);

  Future<Either<Failure, Response>> dioRequest({
    required String url,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool includeTokenProtection = true,
  }) async {
    try {
      final response = await _dioClient.request(
        url: url,
        method: method,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        includeTokenProtection: includeTokenProtection,
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(Failure.noNetwork());
      } else {
        return Left(Failure.unknownServerError(DioExceptions.fromDioError(e).message));
      }
    } catch (e) {
      return Left(Failure.unknownServerError('Unexpected error occurred: $e'));
    }
  }
}
