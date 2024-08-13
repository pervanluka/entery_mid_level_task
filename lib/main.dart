import 'dart:async';
import 'package:entery_mid_level_task/app_bloc_observer.dart';
import 'package:entery_mid_level_task/feature/bloc_wrapper.dart';
import 'package:entery_mid_level_task/feature/theme/theme_cubit.dart';
import 'package:entery_mid_level_task/models/theme_entity/theme_mode_entity.dart';
import 'package:entery_mid_level_task/service/hive/hive_init.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:entery_mid_level_task/shared/app_theme.dart';
import 'package:entery_mid_level_task/shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/logger.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await ServiceLocator.instance.init();
    await HiveSetUp.init();

    Bloc.observer = AppBlocObserver();
    FlutterNativeSplash.remove();
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
    return BlocWrapper(
      child: BlocBuilder<ThemeCubit, ThemeModeEntity>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: router,
            theme: AppTheme.lightThemeData,
            darkTheme: AppTheme.darkThemeData,
            themeMode: state == ThemeModeEntity.dark
                ? ThemeMode.dark
                : state == ThemeModeEntity.light
                    ? ThemeMode.light
                    : ThemeMode.system,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
