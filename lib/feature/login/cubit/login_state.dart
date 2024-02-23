import 'package:entery_mid_level_task/models/user_profile_model.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoggedOutState extends LoginState {}

class LoadingState extends LoginState {}

class LoggedInState extends LoginState {
  final UserProfileModel userProfileModel;

  LoggedInState({required this.userProfileModel});
}

class LoginFailure extends LoginState {
  final Failure failure;

  LoginFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
