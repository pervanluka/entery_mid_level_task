import 'package:entery_mid_level_task/feature/theme/theme_cubit.dart';
import 'package:entery_mid_level_task/models/theme_entity/theme_mode_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitcherButton extends StatelessWidget {
  const ThemeSwitcherButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeModeEntity>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(state == ThemeModeEntity.dark ? Icons.dark_mode : Icons.light_mode),
          onPressed: () {
            final newMode =
                state == ThemeModeEntity.dark ? ThemeModeEntity.light : ThemeModeEntity.dark;
            context.read<ThemeCubit>().changeThemeMode(newMode);
          },
        );
      },
    );
  }
}
