import 'dart:async';

import 'package:entery_mid_level_task/models/user_profile_model.dart';
import 'package:entery_mid_level_task/service/auth/auth_service.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;
  late final Box<UserProfileModel> _userProfileBox;

  ProfileCubit({required AuthService authService})
      : _authService = authService,
        super(UserProfileInitialState());

  final logger = Logger();

  Future<void> init() async {
    _userProfileBox = await Hive.openBox<UserProfileModel>('user_profile');
    logger.w(_userProfileBox.keys);
    _userProfileBox.watch().listen((event) {
      final userProfile = event.value;
      emit(UserProfileState(profileModel: userProfile));
    });
    emit(UserProfileState(profileModel: _userProfileBox.values.first));
  }

  void signOut() {
    _authService.signOut();
  }
}
