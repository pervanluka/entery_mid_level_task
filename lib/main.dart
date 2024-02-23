import 'dart:async';
import 'package:entery_mid_level_task/feature/login/cubit/login_cubit.dart';
import 'package:entery_mid_level_task/feature/root_app/cubit/root_app_cubit.dart';
import 'package:entery_mid_level_task/feature/root_app/root_app.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await ServiceLocator.instance.init();

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
    return MaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          // primaryColor: Colors.indigo,
          // colorScheme: ColorScheme.dark(),
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Assignment',
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RootAppCubit(
                sharedPreferences: getIt(),
              )..checkIsUserAlreadyLogged(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(
                loginService: getIt(),
                flutterSecureStorage: getIt(),
                sharedPreferences: getIt(),
              ),
            ),
          ],
          child: const RootApp(),
        ));
  }
}
