import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';
import 'package:top_up_ticket/shared/view/cubits/add_beneficiary/add_beneficiary_cubit.dart';
import 'package:top_up_ticket/shared/view/cubits/add_beneficiary/add_beneficiary_state.dart';

class MockBeneficiaryRepository extends Mock implements BeneficiaryRepository {}

void main() {
  late AddBeneficiaryCubit addBeneficiaryCubit;
  late BeneficiaryRepository beneficiaryRepository;

  setUp(() {
    beneficiaryRepository = MockBeneficiaryRepository();
    addBeneficiaryCubit = AddBeneficiaryCubit(
      beneficiaryRepository: beneficiaryRepository,
    );
  });

  test('initial state should be InitialState', () {
    expect(
        addBeneficiaryCubit.state, equals(const AddBeneficiaryState.initial()));
  });

  group('addBeneficiary', () {
    blocTest(
      'Should emit $LoadingState and $SuccessState',
      setUp: () {
        when(() => beneficiaryRepository.addBeneficiary(
                nickname: any(named: 'nickname'),
                phoneNumber: any(named: 'phoneNumber')))
            .thenAnswer((_) async => const Right(null));
      },
      build: () => addBeneficiaryCubit,
      act: (bloc) => addBeneficiaryCubit.addBeneficiary(
        nickname: 'nickname',
        phoneNumber: 'phoneNumber',
      ),
      expect: () => [
        const AddBeneficiaryState.loading(),
        const AddBeneficiaryState.success(),
      ],
    );

    blocTest(
      'Should emit $LoadingState and $FieldMissingState',
      build: () => addBeneficiaryCubit,
      act: (bloc) => addBeneficiaryCubit.addBeneficiary(
        nickname: '',
        phoneNumber: '',
      ),
      expect: () => [
        const AddBeneficiaryState.loading(),
        const AddBeneficiaryState.fieldMissing(),
      ],
    );

    blocTest(
      'Should emit $LoadingState and $AlreadyExistsState',
      setUp: () {
        when(() => beneficiaryRepository.addBeneficiary(
                nickname: any(named: 'nickname'),
                phoneNumber: any(named: 'phoneNumber')))
            .thenAnswer((_) async => Left(AlreadyExistsFailure()));
      },
      build: () => addBeneficiaryCubit,
      act: (bloc) => addBeneficiaryCubit.addBeneficiary(
        nickname: 'nickname',
        phoneNumber: 'phoneNumber',
      ),
      expect: () => [
        const AddBeneficiaryState.loading(),
        const AddBeneficiaryState.alreadyExists(),
      ],
    );

    blocTest(
      'Should emit $LoadingState and $MaxBeneficiariesReachedState',
      setUp: () {
        when(() => beneficiaryRepository.addBeneficiary(
                nickname: any(named: 'nickname'),
                phoneNumber: any(named: 'phoneNumber')))
            .thenAnswer((_) async => Left(LimitExceededFailure()));
      },
      build: () => addBeneficiaryCubit,
      act: (bloc) => addBeneficiaryCubit.addBeneficiary(
        nickname: 'nickname',
        phoneNumber: 'phoneNumber',
      ),
      expect: () => [
        const AddBeneficiaryState.loading(),
        const AddBeneficiaryState.maxBeneficiariesReached(),
      ],
    );

    blocTest(
      'Should emit $LoadingState and $GeneralErrorState',
      setUp: () {
        when(() => beneficiaryRepository.addBeneficiary(
                nickname: any(named: 'nickname'),
                phoneNumber: any(named: 'phoneNumber')))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => addBeneficiaryCubit,
      act: (bloc) => addBeneficiaryCubit.addBeneficiary(
        nickname: 'nickname',
        phoneNumber: 'phoneNumber',
      ),
      expect: () => [
        const AddBeneficiaryState.loading(),
        const AddBeneficiaryState.generalError(),
      ],
    );
  });
}
