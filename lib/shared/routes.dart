import 'package:entery_mid_level_task/feature/authentication/cubit/auth_cubit.dart';
import 'package:entery_mid_level_task/feature/authentication/login_page.dart';
import 'package:entery_mid_level_task/feature/products/product_detail/product_detail.dart';
import 'package:entery_mid_level_task/feature/products/products_page.dart';
import 'package:entery_mid_level_task/feature/logs/log_page.dart';
import 'package:entery_mid_level_task/feature/profile/cubit/profile_cubit.dart';
import 'package:entery_mid_level_task/feature/root_app.dart';
import 'package:entery_mid_level_task/feature/profile/profile_page.dart';
import 'package:entery_mid_level_task/models/products/products_model.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:entery_mid_level_task/feature/authentication/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellProductsNavigatorKey = GlobalKey<NavigatorState>();
final _shellLogsNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/products',
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => GoRouter.of(context).go("/products"),
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
    GoRoute(
      path: '/products/details/:id',
      builder: (context, state) {
        final String id = state.pathParameters['id']!;
        final Product product = state.extra as Product;
        return ProductDetailPage(id: id, product: product);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootApp(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellProductsNavigatorKey,
          routes: [
            GoRoute(
              path: '/products',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProductsPage(),
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
