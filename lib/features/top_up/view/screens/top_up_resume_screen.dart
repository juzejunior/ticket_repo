import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_up_ticket/core/extensions/double_money_formatter.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_resume_cubit.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_resume_state.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/view/widgets/top_up_snackbar.dart';

class TopUpResumeScreen extends StatelessWidget {
  const TopUpResumeScreen({
    super.key,
    required this.beneficiary,
    required this.topUpValue,
  });

  final Beneficiary beneficiary;
  final int topUpValue;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopUpResumeCubit(
        userRepository: context.read(),
        transactionRepository: context.read(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top up resume'),
        ),
        body: BlocConsumer<TopUpResumeCubit, TopUpResumeState>(
          listener: _listenToState,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'You are top-upping',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${topUpValue.toDouble().formatAsMoney()} to ${beneficiary.nickName}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(height: 40),
                      _InfoItem(
                        label: 'Phone Number',
                        value: beneficiary.phoneNumber,
                      ),
                      const SizedBox(height: 16),
                      _InfoItem(
                        label: 'Top-up date',
                        value: formatDate(
                            DateTime.now(), [mm, '/', dd, '/', yyyy]),
                      ),
                      Text(
                        'A charge of AED ${GlobalConstants.topUpFee} will be applied to your top-up',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state is LoadingState) return;

                        context.read<TopUpResumeCubit>().confirmTopUp(
                              topUpValue: topUpValue,
                              beneficiary: beneficiary,
                            );
                      },
                      child: state is LoadingState
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator.adaptive())
                          : const Text('Confirm Payment'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _listenToState(BuildContext context, TopUpResumeState state) {
    switch (state) {
      case LoadingState():
        break;
      case SuccessState():
        TopUpSnackbar.showSuccess(context, 'Top-up requested succesfully!');
        while (context.canPop()) {
          context.pop();
        }
        break;
      case NetworkErrorState():
        TopUpSnackbar.showFailure(
          context,
          'No Internet Connection. Please check your connection and try again.',
        );
        break;
      case InsufficientBalanceState():
        TopUpSnackbar.showFailure(
          context,
          'Insufficient balance. Please top-up your account.',
        );
        break;
      case MonthLimitExceededState():
        TopUpSnackbar.showFailure(
          context,
          'You have exceeded the monthly top-up limit of AED ${GlobalConstants.maxTopUpPerMonth}.',
        );
        break;
      case MonthLimitPerBeneficiaryExceededState():
        TopUpSnackbar.showFailure(
          context,
          'You have exceeded the monthly top-up limit for this beneficiary.',
        );
        break;
      default:
        break;
    }
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Divider(),
      ],
    );
  }
}
