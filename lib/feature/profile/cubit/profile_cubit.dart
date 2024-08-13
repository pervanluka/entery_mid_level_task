import 'dart:async';

import 'package:entery_mid_level_task/models/user_profile/user_profile_model.dart';
import 'package:entery_mid_level_task/service/failure/failure.dart';
import 'package:entery_mid_level_task/service/hive/local_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ILocalStorage _localStorage;
  late final Box<UserProfileModel> _userProfileBox;

  ProfileCubit({required ILocalStorage localStorage})
      : _localStorage = localStorage,
        super(UserProfileInitialState());

  final logger = Logger();

  Future<void> init() async {
    _userProfileBox = await Hive.openBox<UserProfileModel>('user_profile');
    logger.i('ProfileCubit _userProfileBox is open: ${_userProfileBox.isOpen}');
    _localStorage.userProfileChanged.listen(
      (event) {
        if (event != null) {
          emit(UserProfileState(profileModel: event));
        } else {
          emit(UserProfileReadyForSignOut());
        }
      },
      onDone: () => logger.t('userProfileChanged listen is done!'),
      onError: (e) => logger.e('Someting happened with userProfileChanged stream: ${e.toString()}'),
    );
    final user = _userProfileBox.values.firstOrNull;
    if (user != null) {
      emit(
        UserProfileState(profileModel: _userProfileBox.values.first),
      );
    } else {
      emit(
        UserProfileFailureState(
          failure: Failure.unknownServerError(),
        ),
      );
    }
  }

  void signOut() {
    emit(UserProfileReadyForSignOut());
  }
}
