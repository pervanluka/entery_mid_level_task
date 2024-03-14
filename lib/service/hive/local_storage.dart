import 'package:entery_mid_level_task/models/user_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract interface class ILocalStorage {
  Future<void> init();
  Stream<UserProfileModel?> get userProfileChanged;
}

class LocalStorage implements ILocalStorage {
  Box<UserProfileModel>? userBox;
  @override
  Future<void> init() async {
    final box = userBox;

    if (box == null || box.isEmpty) {
      userBox = await Hive.openBox<UserProfileModel>('user_profile');
    }
  }

  @override
  Stream<UserProfileModel?> get userProfileChanged {
    final box = userBox;
    if (box == null || box.isOpen) {
      throw Exception('user box not open yet');
    }

    return box.watch(key: 'user').asBroadcastStream().map((e) => e.value as UserProfileModel?);
  }
}
