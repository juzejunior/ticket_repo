import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/cubit/mobile_recharge_cubit.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/cubit/mobile_recharge_state.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/widgets/mobile_recharge_header.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/widgets/mobile_recharge_section.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => MobileRechargeCubit(
          userRepository: context.read<UserRepository>(),
          beneficiaryRepository: context.read<BeneficiaryRepository>(),
        )..loadData(),
      ),
    ], child: const _RechargeScreenContent());
  }
}

class _RechargeScreenContent extends StatelessWidget {
  const _RechargeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<MobileRechargeCubit, MobileRechargeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          networkError: () => const Center(
            child: Text(
                'No Internet Connection. Please check your connection and try again.'),
          ),
          generalError: () => const Center(
            child: Text('Something went wrong. Please try again later.'),
          ),
          success: (user, beneficiaries) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  MobileRechargeHeader(userName: user.name),
                  const SizedBox(height: 50),
                  MobileRechargeSection(
                    beneficiaries: beneficiaries,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
