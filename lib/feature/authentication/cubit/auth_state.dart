import 'package:entery_mid_level_task/models/user_profile/user_profile_model.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final UserProfileModel userProfileModel;

  Authenticated({required this.userProfileModel});
}

class AuthenticateFailure extends AuthState {
  final Failure failure;

  AuthenticateFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
