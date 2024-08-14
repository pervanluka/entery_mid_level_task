import 'package:entery_mid_level_task/feature/sort/cubit/sort_cubit.dart';
import 'package:entery_mid_level_task/feature/sort/cubit/sort_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SortPage extends StatelessWidget {
  const SortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SortCubit(),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<SortCubit, SortState>(
            builder: (ctx, state) {
              if (state is SortInitial) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (() => ctx.read<SortCubit>().onButtonPressed()),
                      child: const Text('Press me'),
                    ),
                  ],
                );
              } else if (state is SortLoading) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.elapsedTime),
                      const Gap(12),
                      const CircularProgressIndicator.adaptive(),
                    ],
                  ),
                );
              } else if (state is SortReady) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (() => ctx.read<SortCubit>().onButtonPressed()),
                      child: const Text('Press me'),
                    ),
                    const Gap(10),
                    Text(state.timeTaken),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
