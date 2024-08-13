import 'package:entery_mid_level_task/models/user_profile/user_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

abstract interface class ILocalStorage {
  Future<void> init();
  Stream<UserProfileModel?> get userProfileChanged;
}

class LocalStorage implements ILocalStorage {
  Box<UserProfileModel>? userBox;
  final logger = Logger();
  @override
  Future<void> init() async {
    logger.i('Local Storage initializing...');
    final box = userBox;

    if (box == null || box.isEmpty) {
      userBox = await Hive.openBox<UserProfileModel>('user_profile');
      logger.i('userBox: ${userBox?.keys}');
    }
  }

  @override
  Stream<UserProfileModel?> get userProfileChanged {
    final box = userBox;
    logger.i('Is box open? ${box?.isOpen}');
    return box?.watch(key: 'user').asBroadcastStream().map((e) => e.value as UserProfileModel?) ??
        const Stream.empty();
  }
}
