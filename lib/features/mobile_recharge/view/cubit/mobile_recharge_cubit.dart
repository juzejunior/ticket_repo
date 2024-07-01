import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/cubit/mobile_recharge_state.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class MobileRechargeCubit extends Cubit<MobileRechargeState> {
  MobileRechargeCubit({
    required this.userRepository,
    required this.beneficiaryRepository,
  }) : super(const MobileRechargeState.initial());

  final UserRepository userRepository;
  final BeneficiaryRepository beneficiaryRepository;
  StreamSubscription<List<Beneficiary>>? beneficiariesSubscription;

  Future<void> loadData() async {
    emit(const MobileRechargeState.loading());

    final userResult = await userRepository.getUser();

    userResult.fold(
      (error) {
        if (error is NetworkFailure) {
          return emit(const MobileRechargeState.networkError());
        }
        return emit(const MobileRechargeState.generalError());
      },
      (user) => emit(MobileRechargeState.success(
        user,
        [],
      )),
    );

    _listenToBeneficiaries();
  }

  void _listenToBeneficiaries() {
    final beneficiariesStream = beneficiaryRepository.beneficiariesStream;
    beneficiariesSubscription = beneficiariesStream.listen((beneficiaries) {
      if (state is SuccessState) {
        final successState = state as SuccessState;
        emit(MobileRechargeState.success(
          successState.user,
          beneficiaries,
        ));
        return;
      }
    });
  }

  @override
  Future<void> close() {
    beneficiariesSubscription?.cancel();
    return super.close();
  }
}
