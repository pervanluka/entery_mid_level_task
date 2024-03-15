import 'package:entery_mid_level_task/feature/authentication/cubit/auth_cubit.dart';
import 'package:entery_mid_level_task/feature/authentication/login_page.dart';
import 'package:entery_mid_level_task/feature/home/home_page.dart';
import 'package:entery_mid_level_task/feature/logs/log_page.dart';
import 'package:entery_mid_level_task/feature/profile/cubit/profile_cubit.dart';
import 'package:entery_mid_level_task/feature/root_app.dart';
import 'package:entery_mid_level_task/feature/profile/profile_page.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:entery_mid_level_task/shared/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellHomeNavigatorKey = GlobalKey<NavigatorState>();
final _shellLogsNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => GoRouter.of(context).go("/home"),
          child: const Text("Go to home page"),
        ),
      ),
    ),
  ),
  redirect: (context, state) async {
    final token = await getIt<FlutterSecureStorage>().read(key: 'token');
    if (token == null) {
      return '/login';
    } else {
      return null;
    }
  },
  refreshListenable: AuthNotifier(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (_) => AuthCubit(
          loginService: getService(),
          flutterSecureStorage: getService(),
          sharedPreferences: getService(),
        ),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => BlocProvider.value(
        value: state.extra! as ProfileCubit,
        child: const ProfilePage(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootAppWrapper(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellHomeNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellLogsNavigatorKey,
          routes: [
            GoRoute(
              path: '/logs',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LogsPage(),
              ),
            ),
          ],
        ),

        // Add more routes as needed
      ],
    ),
  ],
);
