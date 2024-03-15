import 'package:entery_mid_level_task/feature/authentication/cubit/auth_cubit.dart';
import 'package:entery_mid_level_task/feature/authentication/cubit/auth_state.dart';
import 'package:entery_mid_level_task/feature/shared/app_text_field.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticating) {
          showDialog(
            context: context,
            builder: (context) => const Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
          );
        }
        if (state is AuthenticateFailure) {
          Navigator.of(context).pop();
          context.showErrorBar(
            content: Text(state.failure.description),
            position: FlashPosition.bottom,
            duration: const Duration(seconds: 3),
          );
        }
        if (state is Authenticated) {
          Navigator.of(context).pop();
          GoRouter.of(context).go('/home');
        }
        if (state is Unauthenticated) {
          GoRouter.of(context).go('/login');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Icon(
                      Icons.lock_person,
                      size: 150,
                    ),
                  ),
                  const Gap(32),
                  AppTextField(
                    controller: _usernameController,
                    label: 'Username',
                    isObscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    isObscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const Gap(32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      backgroundColor: Colors.indigo,
                      minimumSize: const Size(
                        double.infinity,
                        48,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              _usernameController.text.trim(),
                              _passwordController.text.trim(),
                            );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
