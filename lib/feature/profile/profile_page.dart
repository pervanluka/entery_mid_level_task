import 'package:cached_network_image/cached_network_image.dart';
import 'package:entery_mid_level_task/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
          ),
          body: Builder(
            builder: (context) {
              return switch (state) {
                UserProfileInitialState() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              state.profileModel.lastName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Gap(32),
                        Row(
                          children: [
                            const Text(
                              'Username: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(state.profileModel.username)
                          ],
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            const Text(
                              'Gender: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(state.profileModel.gender)
                          ],
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            const Text(
                              'E-mail: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(state.profileModel.email)
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                            label: const Text('Sign Out'),
                            icon: const Icon(Icons.logout),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white70,
                              backgroundColor: Colors.indigo,
                              minimumSize: const Size(
                                double.infinity,
                                48,
                              ),
                            ),
                            onPressed: () {
                              context.read<ProfileCubit>().signOut();
                              // context.go('/login');
                            })
                      ],
                    ),
                  ),
                _ => const Center(
                    child: Text('Error'),
                  )
              };
            },
          ),
        );
      },
    );
  }
}
