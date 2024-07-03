import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_ticket/core/extensions/double_money_formatter.dart';
import 'package:top_up_ticket/core/router/router.dart';
import 'package:top_up_ticket/core/router/screen_name.dart';
import 'package:top_up_ticket/features/top_up/domain/entities/top_up.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_cubit.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_state.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/view/widgets/top_up_snackbar.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({
    super.key,
    required this.beneficiary,
  });

  final Beneficiary beneficiary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopUpCubit(
        userRepository: context.read(),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Top up'),
          ),
          floatingActionButton: BlocBuilder<TopUpCubit, TopUpState>(
            builder: (context, state) {
              return FloatingActionButton(
                backgroundColor:
                    state.isValid ? null : Colors.grey.withOpacity(0.5),
                onPressed: () {
                  if (state.isValid) {
                    context.goNamed(
                      ScreenNames.topupResume,
                      extra: TopUpScreenExtraArgs(
                        beneficiary: beneficiary,
                        topUpValue: state.selectedTopUp ?? 0,
                      ),
                    );
                  }
                },
                child: const Icon(Icons.arrow_forward),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: BlocConsumer<TopUpCubit, TopUpState>(
                listener: (context, state) {
                  if (state.hasError ?? false) {
                    TopUpSnackbar.showFailure(
                        context, 'Failed to load data. Please try again.');
                  }
                },
                builder: (context, state) {
                  if (state.isLoading ?? false) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopUpHeader(
                        beneficiary.nickName,
                        beneficiary.phoneNumber,
                        state.user?.balance ?? 0,
                      ),
                      const SizedBox(height: 20),
                      _TopUpOptions(
                        groupValue: state.selectedTopUp ?? 0,
                        topUps: state.topUps ?? [],
                        onChanged: (value) {
                          context.read<TopUpCubit>().selectTopUp(value);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
}

class _TopUpHeader extends StatelessWidget {
  const _TopUpHeader(
    this.nickName,
    this.phoneNumber,
    this.balance,
  );

  final String nickName;
  final String phoneNumber;
  final int balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'What is the top-up value?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Balance available: ${balance.toDouble().formatAsMoney()}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}

class _TopUpOptions extends StatelessWidget {
  const _TopUpOptions({
    required this.topUps,
    required this.groupValue,
    required this.onChanged,
  });

  final int groupValue;
  final List<TopUp> topUps;
  final Function(int? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: topUps
            .map(
              (topUp) => Column(
                children: [
                  RadioListTile(
                    value: topUp.value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    title: Text(
                      topUp.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            )
            .toList());
  }
}
