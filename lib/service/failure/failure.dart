import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String description;

  const Failure({required this.description});

  factory Failure.noNetwork() => const NoNetwork(description: 'No Internet Connection');
  factory Failure.unknownServerError([
    String description = 'Unknown Server error',
  ]) =>
      UnknownServerError(
        description: description,
      );

  @override
  List<Object?> get props => [description];
}

class UnknownServerError extends Failure {
  const UnknownServerError({required super.description});
}

class NoNetwork extends Failure {
  const NoNetwork({required super.description});
}
