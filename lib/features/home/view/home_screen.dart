import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/features/home/view/cubit/home_cubit.dart';
import 'package:top_up_ticket/features/home/view/cubit/home_state.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => HomeCubit(
          context.read<UserRepository>(),
        )..loadData(),
      ),
    ], child: const _HomeScreenContent());
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              networkError: () => const Center(
                child: Text('Network Error'),
              ),
              generalError: () => const Center(
                child: Text('Something went wrong. Please try again later.'),
              ),
              success: (user) => Center(
                child: Text('Welcome, ${user.name}'),
              ),
            );
          },
        ));
  }
}
