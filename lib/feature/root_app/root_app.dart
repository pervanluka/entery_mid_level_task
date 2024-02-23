import 'package:entery_mid_level_task/feature/home.dart';
import 'package:entery_mid_level_task/feature/login/login_page.dart';
import 'package:entery_mid_level_task/feature/root_app/cubit/root_app_cubit.dart';
import 'package:entery_mid_level_task/feature/root_app/cubit/root_app_state.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootAppCubit, RootAppState>(
      listener: (context, state) {
        // if (state is RootAppInitial) {
        //   context.read<RootAppCubit>().checkIsUserAlreadyLogged();
        // }
        if (state is RootAppFailure) {
          context.showFlash(
            builder: (context, controller) => FlashBar(
              content: Text(state.failure.description),
              controller: controller,
              insetAnimationDuration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return switch (state) {
          RootAppLoggedOut() => const LoginPage(),
          RootAppStayLogged() => const Home(),
          _ => const Center(child: CircularProgressIndicator.adaptive()),
        };
      },
    );
  }
}
