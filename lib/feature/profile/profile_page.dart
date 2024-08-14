import 'package:cached_network_image/cached_network_image.dart';
import 'package:entery_mid_level_task/feature/profile/cubit/profile_cubit.dart';
import 'package:entery_mid_level_task/shared/widgets/theme_switcher_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: const [ThemeSwitcherButton()],
          ),
          body: Builder(
            builder: (context) {
              return switch (state) {
                UserProfileState() => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(32),
                        Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: CachedNetworkImageProvider(
                              state.profileModel.image,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.profileModel.firstName,
                              style: theme.textTheme.titleLarge,
                            ),
                            const Gap(8),
                            Text(
                              state.profileModel.lastName,
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Gap(32),
                        Row(
                          children: [
                            Text(
                              'Username: ',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              state.profileModel.username,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              state.profileModel.gender,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            Text(
                              'E-mail: ',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              state.profileModel.email,
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                            label: const Text('Sign Out'),
                            icon: const Icon(Icons.logout),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(
                                double.infinity,
                                48,
                              ),
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                            ),
                            onPressed: () {
                              context.read<ProfileCubit>().signOut();
                              GoRouter.of(context).go('/login');
                            })
                      ],
                    ),
                  ),
                _ => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              };
            },
          ),
        );
      },
    );
  }
}
