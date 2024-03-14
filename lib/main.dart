import 'dart:async';
import 'package:entery_mid_level_task/app_bloc_observer.dart';
import 'package:entery_mid_level_task/service/hive/hive_init.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:entery_mid_level_task/shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await ServiceLocator.instance.init();
    await HiveSetUp.init();

    Bloc.observer = AppBlocObserver();

    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) async {
    final logger = Logger();
    logger.e('Error', error: error, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade800,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
