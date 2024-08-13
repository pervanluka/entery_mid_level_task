import 'package:cached_network_image/cached_network_image.dart';
import 'package:entery_mid_level_task/feature/authentication/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:entery_mid_level_task/feature/profile/cubit/profile_cubit.dart';

class RootApp extends StatelessWidget {
  const RootApp({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Assignment",
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => GoRouter.of(context).push(
                '/profile',
                extra: context.read<ProfileCubit>(),
              ),
              icon: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is UserProfileReadyForSignOut) {
                    context.read<AuthCubit>().signOut();
                  }
                },
                builder: (context, state) {
                  return switch (state) {
                    UserProfileInitialState() => const SizedBox.square(
                        dimension: 40,
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    UserProfileState() => CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          state.profileModel.image,
                        ),
                      ),
                    _ => const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                  };
                },
              ),
            )
          ],
        ),
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          destinations: const [
            NavigationDestination(
              label: 'Products',
              icon: Icon(Icons.settings_input_component_sharp),
            ),
            NavigationDestination(
              label: 'Logs',
              icon: Icon(Icons.logo_dev_sharp),
            ),
          ],
        ));
  }
}
