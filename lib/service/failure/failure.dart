import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String description;
  final String errorCode;

  const Failure({
    required this.description,
    required this.errorCode,
  });

  factory Failure.noNetwork() => const NoNetworkFailure(
        description: 'No Internet Connection',
        errorCode: 'ERROR_NO_NETWORK',
      );

  factory Failure.connectionTimeout() => const ConnectionTimeoutFailure(
        description: 'Connection timeout with API server',
        errorCode: 'ERROR_CONNECTION_TIMEOUT',
      );

  factory Failure.receiveTimeout() => const ReceiveTimeoutFailure(
        description: 'Receive timeout in connection with API server',
        errorCode: 'ERROR_RECEIVE_TIMEOUT',
      );

  factory Failure.sendTimeout() => const SendTimeoutFailure(
        description: 'Send timeout in connection with API server',
        errorCode: 'ERROR_SEND_TIMEOUT',
      );

  factory Failure.requestCancelled() => const RequestCancelledFailure(
        description: 'Request to API server was cancelled',
        errorCode: 'ERROR_REQUEST_CANCELLED',
      );

  factory Failure.badRequest([String? message]) => BadRequestFailure(
        description: message ?? 'Bad request',
        errorCode: 'ERROR_BAD_REQUEST',
      );

  factory Failure.unauthorized() => const UnauthorizedFailure(
        description: 'Unauthorized',
        errorCode: 'ERROR_UNAUTHORIZED',
      );

  factory Failure.forbidden() => const ForbiddenFailure(
        description: 'Forbidden',
        errorCode: 'ERROR_FORBIDDEN',
      );

  factory Failure.notFound([String? message]) => NotFoundFailure(
        description: message ?? 'Resource not found',
        errorCode: 'ERROR_NOT_FOUND',
      );

  factory Failure.internalServerError() => const InternalServerErrorFailure(
        description: 'Internal server error',
        errorCode: 'ERROR_INTERNAL_SERVER',
      );

  factory Failure.badGateway() => const BadGatewayFailure(
        description: 'Bad gateway',
        errorCode: 'ERROR_BAD_GATEWAY',
      );

  factory Failure.serviceUnavailable() => const ServiceUnavailableFailure(
        description: 'Service temporarily unavailable',
        errorCode: 'ERROR_SERVICE_UNAVAILABLE',
      );

  factory Failure.unknownServerError([String? description]) => UnknownServerErrorFailure(
        description: description ?? 'Unknown server error',
        errorCode: 'ERROR_UNKNOWN_SERVER',
      );

  factory Failure.unexpectedError([String? description]) => UnexpectedErrorFailure(
        description: description ?? 'Unexpected error occurred',
        errorCode: 'ERROR_UNEXPECTED',
      );

  factory Failure.donwloadFile([String? description]) => UnexpectedErrorFailure(
        description: description ?? 'Unable to download file',
        errorCode: 'ERROR_DOWNLOAD_FILE',
      );

  @override
  List<Object?> get props => [description, errorCode];
}

class NoNetworkFailure extends Failure {
  const NoNetworkFailure({
    required super.description,
    required super.errorCode,
  });
}

class ConnectionTimeoutFailure extends Failure {
  const ConnectionTimeoutFailure({
    required super.description,
    required super.errorCode,
  });
}

class ReceiveTimeoutFailure extends Failure {
  const ReceiveTimeoutFailure({
    required super.description,
    required super.errorCode,
  });
}

class SendTimeoutFailure extends Failure {
  const SendTimeoutFailure({
    required super.description,
    required super.errorCode,
  });
}

class RequestCancelledFailure extends Failure {
  const RequestCancelledFailure({
    required super.description,
    required super.errorCode,
  });
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({
    required super.description,
    required super.errorCode,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.description,
    required super.errorCode,
  });
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    required super.description,
    required super.errorCode,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.description,
    required super.errorCode,
  });
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure({
    required super.description,
    required super.errorCode,
  });
}

class BadGatewayFailure extends Failure {
  const BadGatewayFailure({
    required super.description,
    required super.errorCode,
  });
}

class ServiceUnavailableFailure extends Failure {
  const ServiceUnavailableFailure({
    required super.description,
    required super.errorCode,
  });
}

class UnknownServerErrorFailure extends Failure {
  const UnknownServerErrorFailure({
    required super.description,
    required super.errorCode,
  });
}

class UnexpectedErrorFailure extends Failure {
  const UnexpectedErrorFailure({
    required super.description,
    required super.errorCode,
  });
}
