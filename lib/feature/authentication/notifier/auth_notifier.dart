// ignore_for_file: unused_field

import 'package:entery_mid_level_task/models/user_profile/user_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthNotifier extends ValueNotifier<UserProfileModel?> implements Listenable {
  AuthNotifier() : super(null) {
    _init();
  }

  VoidCallback? _routerListener;

  void _init() async {
    await Hive.openBox<UserProfileModel>('user_profile');
    final initialProfile = Hive.box<UserProfileModel>('user_profile').get('user');
    value = initialProfile;
    Hive.box<UserProfileModel>('user_profile').watch().listen(
          (event) => value = event.value,
        );
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
