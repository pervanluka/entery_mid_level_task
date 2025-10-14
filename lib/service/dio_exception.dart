import 'package:dio/dio.dart';
import 'package:entry_mid_level_task/service/failure/failure.dart';

class DioExceptionHandler {
  static Failure handleDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return Failure.requestCancelled();

      case DioExceptionType.connectionTimeout:
        return Failure.connectionTimeout();

      case DioExceptionType.receiveTimeout:
        return Failure.receiveTimeout();

      case DioExceptionType.sendTimeout:
        return Failure.sendTimeout();

      case DioExceptionType.badResponse:
        return _handleHttpError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.unknown:
        return _handleUnknownError(dioException);

      default:
        return Failure.unexpectedError('Something went wrong');
    }
  }

  static Failure _handleHttpError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        String? errorMessage;
        if (error is Map<String, dynamic> && error['message'] != null) {
          errorMessage = error['message'].toString();
        }
        return Failure.badRequest(errorMessage);

      case 401:
        return Failure.unauthorized();

      case 403:
        return Failure.forbidden();

      case 404:
        String? errorMessage;
        if (error is Map<String, dynamic> && error['message'] != null) {
          errorMessage = error['message'].toString();
        }
        return Failure.notFound(errorMessage);

      case 500:
        return Failure.internalServerError();

      case 502:
        return Failure.badGateway();

      case 503:
        return Failure.serviceUnavailable();

      default:
        return Failure.unknownServerError('HTTP Error: ${statusCode ?? 'Unknown status code'}');
    }
  }

  static Failure _handleUnknownError(DioException dioException) {
    final message = dioException.message ?? '';

    // Check for network connectivity issues
    if (message.contains('SocketException') ||
        message.contains('Network is unreachable') ||
        message.contains('No address associated with hostname')) {
      return Failure.noNetwork();
    }

    // Check for timeout related issues in unknown errors
    if (message.contains('timeout')) {
      return Failure.connectionTimeout();
    }

    return Failure.unexpectedError('Unexpected error: $message');
  }
}
