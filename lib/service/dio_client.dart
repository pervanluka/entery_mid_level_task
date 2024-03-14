import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:entery_mid_level_task/constants/app_endpoints.dart';
import 'package:entery_mid_level_task/service/auth/auth_service.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage flutterSecureStorage;

  DioClient(this._dio, this.flutterSecureStorage) {
    _dio
      ..options.baseUrl = AppEndpoits.baseUrl
      ..options.connectTimeout = const Duration(milliseconds: 10000)
      ..options.receiveTimeout = const Duration(milliseconds: 10000)
      ..options.responseType = ResponseType.json
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ));
  }

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioException(
        type: DioExceptionType.connectionTimeout,
        error: 'No internet connection',
        requestOptions: options,
      ));
    }
    return handler.next(options);
  }

  Future<void> _onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response != null && error.response!.statusCode == 403) {
      try {
        final logger = Logger();
        final newToken = await getService<AuthService>().refreshToken();
        await newToken.fold(
          (l) {
            logger.i(error.message);
            handler.reject(error);
          },
          (r) async {
            logger.i('TOKEN: ${r.token}');
            _dio.options.headers['Authorization'] = 'Bearer ${r.token}';
            final response = await _dio.request(
              error.requestOptions.path,
              data: error.requestOptions.data,
              options: Options(
                method: error.requestOptions.method,
                contentType: error.requestOptions.headers['Content-Type'],
              ),
            );
            return handler.resolve(response);
          },
        );
      } catch (e) {
        return handler.reject(error);
      }
    }
  }

  Future<Response> request({
    required String url,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool includeTokenProtection = true,
  }) async {
    try {
      Options options = Options(
        method: method,
        contentType: Headers.jsonContentType,
      );

      if (includeTokenProtection) {
        String? token = await flutterSecureStorage.read(key: 'token');
        if (token != null) {
          options.headers?['Authorization'] = 'Bearer $token';
        }
      }
      final Response response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
