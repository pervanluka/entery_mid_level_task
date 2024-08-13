import 'package:entery_mid_level_task/models/user_profile/user_profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class HiveSetUp {
  static Future<void> init() async {
    final logger = Logger();
    logger.i('Hive box initilizing...');
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDirectory.path);
    await adapterRegistration();
  }

  static Future<void> adapterRegistration() async {
    Hive.registerAdapter(UserProfileModelAdapter());
  }
}
