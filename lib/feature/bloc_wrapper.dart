import 'package:entery_mid_level_task/feature/authentication/cubit/auth_cubit.dart';
import 'package:entery_mid_level_task/feature/sort/cubit/sort_cubit.dart';
import 'package:entery_mid_level_task/feature/products/cubit/products_cubit.dart';
import 'package:entery_mid_level_task/feature/profile/cubit/profile_cubit.dart';
import 'package:entery_mid_level_task/feature/theme/theme_cubit.dart';
import 'package:entery_mid_level_task/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWrapper extends StatelessWidget {
  final Widget child;
  const BlocWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(
            themeRepo: getService(),
          ),
        ),
        BlocProvider(
          create: (_) => AuthCubit(
            loginService: getService(),
            flutterSecureStorage: getService(),
            sharedPreferences: getService(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(
            localStorage: getService(),
          )..init(),
        ),
        BlocProvider(
          create: (_) => ProductsCubit(
            productsRepository: getService(),
          )..getProducts(isRefresh: true),
        ),
        BlocProvider(
          create: (_) => SortCubit(),
        ),
      ],
      child: child,
    );
  }
}
