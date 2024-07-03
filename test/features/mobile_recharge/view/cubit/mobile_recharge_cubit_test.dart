import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/cubit/mobile_recharge_cubit.dart';
import 'package:top_up_ticket/features/mobile_recharge/view/cubit/mobile_recharge_state.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class MockBeneficiaryRepository extends Mock implements BeneficiaryRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MobileRechargeCubit mobileRechargeCubit;
  late UserRepository userRepository;
  late BeneficiaryRepository beneficiaryRepository;

  setUp(() {
    userRepository = MockUserRepository();
    beneficiaryRepository = MockBeneficiaryRepository();
    mobileRechargeCubit = MobileRechargeCubit(
      userRepository: userRepository,
      beneficiaryRepository: beneficiaryRepository,
    );
  });

  test('initial state should be InitialState', () {
    expect(
        mobileRechargeCubit.state, equals(const MobileRechargeState.initial()));
  });

  group('loadData', () {
    blocTest(
      'Should emit $LoadingState and $SuccessState',
      setUp: () {
        when(() => beneficiaryRepository.beneficiariesStream)
            .thenAnswer((_) => Stream.value([]));
        when(() => userRepository.getUser()).thenAnswer(
          (_) async => const Right(
            User(id: 'id', name: 'name', balance: 12, isVerified: true),
          ),
        );
      },
      build: () => mobileRechargeCubit,
      act: (bloc) => mobileRechargeCubit.loadData(),
      expect: () => [
        const MobileRechargeState.loading(),
        const MobileRechargeState.success(
          User(id: 'id', name: 'name', balance: 12, isVerified: true),
          [],
        ),
      ],
    );

    blocTest(
      'Should emit $LoadingState and $NetworkErrorState',
      setUp: () {
        when(() => userRepository.getUser()).thenAnswer(
          (_) async => Left(NetworkFailure()),
        );
        when(() => beneficiaryRepository.beneficiariesStream)
            .thenAnswer((_) => Stream.value([]));
      },
      build: () => mobileRechargeCubit,
      act: (bloc) => mobileRechargeCubit.loadData(),
      expect: () => [
        const MobileRechargeState.loading(),
        const MobileRechargeState.networkError(),
      ],
    );

    blocTest(
      'Should emit $LoadingState and $GeneralErrorState',
      setUp: () {
        when(() => userRepository.getUser()).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        when(() => beneficiaryRepository.beneficiariesStream)
            .thenAnswer((_) => Stream.value([]));
      },
      build: () => mobileRechargeCubit,
      act: (bloc) => mobileRechargeCubit.loadData(),
      expect: () => [
        const MobileRechargeState.loading(),
        const MobileRechargeState.generalError(),
      ],
    );
  });
}
