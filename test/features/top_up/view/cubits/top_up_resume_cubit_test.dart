import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_resume_cubit.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_resume_state.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/repositories/topup_transaction_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockTransactionRepository extends Mock
    implements TopupTransactionRepository {}

void main() {
  late TopUpResumeCubit cubit;
  late UserRepository userRepository;
  late TopupTransactionRepository transactionRepository;

  setUp(() {
    userRepository = MockUserRepository();
    transactionRepository = MockTransactionRepository();
    cubit = TopUpResumeCubit(
      userRepository: userRepository,
      transactionRepository: transactionRepository,
    );
  });

  group('confirmTopUp', () {
    blocTest<TopUpResumeCubit, TopUpResumeState>(
      'should emit loading and network error state',
      build: () => cubit,
      act: (cubit) {
        when(() => userRepository.topUpFeeCharge(any())).thenAnswer(
          (_) async => Left(NetworkFailure()),
        );
        cubit.confirmTopUp(
          topUpValue: 100,
          beneficiary: const Beneficiary(
            nickName: '',
            phoneNumber: '',
          ),
        );
      },
      expect: () => [
        const TopUpResumeState.loading(),
        const TopUpResumeState.networkError(),
      ],
    );

    blocTest<TopUpResumeCubit, TopUpResumeState>(
      'should emit loading and insufficient balance state',
      build: () => cubit,
      act: (cubit) {
        when(() => userRepository.topUpFeeCharge(any())).thenAnswer(
          (_) async => Left(InsufficientBalanceFailure()),
        );
        cubit.confirmTopUp(
            topUpValue: 100,
            beneficiary: const Beneficiary(
              nickName: '',
              phoneNumber: '',
            ));
      },
      expect: () => [
        const TopUpResumeState.loading(),
        const TopUpResumeState.insufficientBalance(),
      ],
    );

    blocTest<TopUpResumeCubit, TopUpResumeState>(
      'should emit loading and general error state',
      build: () => cubit,
      act: (cubit) {
        when(() => userRepository.topUpFeeCharge(any())).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        cubit.confirmTopUp(
            topUpValue: 100,
            beneficiary: const Beneficiary(
              nickName: '',
              phoneNumber: '',
            ));
      },
      expect: () => [
        const TopUpResumeState.loading(),
        const TopUpResumeState.generalError(),
      ],
    );
  });
}
