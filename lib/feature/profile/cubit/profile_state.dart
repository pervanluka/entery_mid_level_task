part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends ProfileState {}

class UserProfileState extends ProfileState {
  final UserProfileModel profileModel;

  const UserProfileState({required this.profileModel});

  @override
  List<Object> get props => [profileModel];
}

class UserProfileReadyForSignOut extends ProfileState {}

class UserProfileFailureState extends ProfileState {
  final Failure failure;

  const UserProfileFailureState({required this.failure});

  @override
  List<Object> get props => [failure];
}
