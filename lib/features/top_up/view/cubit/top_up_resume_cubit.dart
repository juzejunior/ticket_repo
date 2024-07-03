import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_resume_state.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/repositories/topup_transaction_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class TopUpResumeCubit extends Cubit<TopUpResumeState> {
  TopUpResumeCubit({
    required this.userRepository,
    required this.transactionRepository,
  }) : super(const TopUpResumeState.initial());

  final UserRepository userRepository;
  final TopupTransactionRepository transactionRepository;

  Future<void> confirmTopUp({
    required int topUpValue,
    required Beneficiary beneficiary,
  }) async {
    emit(const TopUpResumeState.loading());

    final chargeUserFeeResult = await userRepository.topUpFeeCharge(topUpValue);

    chargeUserFeeResult.fold(
      (error) {
        if (error is NetworkFailure) {
          return emit(const TopUpResumeState.networkError());
        }

        if (error is InsufficientBalanceFailure) {
          return emit(const TopUpResumeState.insufficientBalance());
        }
        return emit(const TopUpResumeState.generalError());
      },
      (_) async {
        final user = userRepository.user;
        final transactionResult = await transactionRepository.addTransaction(
          date: DateTime.now(),
          beneficiary: beneficiary,
          topUpValue: topUpValue,
          isUserVerified: user!.isVerified,
        );

        transactionResult.fold(
          (error) {
            if (error is LimitExceededTotalPerMonthFailure) {
              return emit(const TopUpResumeState.monthLimitExceeded());
            }

            if (error is LimitExceededTotalPerMonthPerBeneficiaryFailure) {
              return emit(
                  const TopUpResumeState.monthLimitPerBeneficiaryExceeded());
            }

            if (error is NetworkFailure) {
              return emit(const TopUpResumeState.networkError());
            }

            return emit(const TopUpResumeState.generalError());
          },
          (_) {
            emit(const TopUpResumeState.success());
          },
        );
      },
    );
  }
}
