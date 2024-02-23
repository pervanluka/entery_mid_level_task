import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:equatable/equatable.dart';

sealed class RootAppState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RootAppInitial extends RootAppState {}

class RootAppStayLogged extends RootAppState {}

class RootAppLoggedOut extends RootAppState {}

class RootAppFailure extends RootAppState {
  final Failure failure;

  RootAppFailure({required this.failure});
}

class RootAppLoading extends RootAppState {}
