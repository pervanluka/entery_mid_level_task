import 'package:entery_mid_level_task/feature/home.dart';
import 'package:entery_mid_level_task/feature/login/cubit/login_cubit.dart';
import 'package:entery_mid_level_task/feature/login/cubit/login_state.dart';
import 'package:entery_mid_level_task/feature/shared/app_text_field.dart';
import 'package:entery_mid_level_task/shared/loading_overlay.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoadingState) {
          LoadingOverlay.instance.show(context);
        }
        if (state is LoginFailure) {
          context.showFlash(
            builder: (context, controller) => FlashBar(
              content: Text(state.failure.description),
              controller: controller,
              behavior: FlashBehavior.floating,
              // insetAnimationDuration: const Duration(seconds: 2),
            ),
          );
        }
        if (state is LoggedInState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }
        LoadingOverlay.instance.hide(context);
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
                        context.read<LoginCubit>().login(
                              _usernameController.text,
                              _passwordController.text,
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
