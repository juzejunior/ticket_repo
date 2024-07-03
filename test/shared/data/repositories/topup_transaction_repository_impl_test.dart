import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/core/network/connection_status.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/topup_transaction_remote_datasource.dart';
import 'package:top_up_ticket/shared/data/repositories/topup_transaction_repository_impl.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/entities/topup_transaction.dart';

class MockTopupTransactionRemoteDatasource extends Mock
    implements TopupTransactionRemoteDatasource {}

class MockConnectionStatus extends Mock implements ConnectionStatus {}

void main() {
  late TopupTransactionRepositoryImpl repository;
  late TopupTransactionRemoteDatasource dataSource;
  late ConnectionStatus connectionStatus;

  setUp(() {
    dataSource = MockTopupTransactionRemoteDatasource();
    connectionStatus = MockConnectionStatus();
    repository = TopupTransactionRepositoryImpl(
      dataSource: dataSource,
      connectionStatus: connectionStatus,
    );
  });

  group('addTransaction', () {
    test('should add transaction to the stream', () async {
      when(() => connectionStatus.isConnected).thenAnswer((_) async => true);

      const topUpValue = 100;
      const beneficiary = Beneficiary(
        nickName: 'nickname',
        phoneNumber: 'phoneNumber',
      );

      final result = await repository.addTransaction(
        date: DateTime.now(),
        beneficiary: beneficiary,
        topUpValue: topUpValue,
        isUserVerified: true,
      );

      expect(result.isRight(), true);
      expect(repository.transactions!.length, 1);
      expect(repository.transactions!.first.value, topUpValue);
      expect(repository.transactions!.first.beneficiary, beneficiary);
    });

    test(
        'should return LimitExceededTotalPerMonthFailure when transaction month limit exceeded',
        () async {
      when(() => connectionStatus.isConnected).thenAnswer((_) async => true);

      const topUpValue = GlobalConstants.maxTopUpPerMonth;
      const beneficiary = Beneficiary(
        nickName: 'nickname',
        phoneNumber: 'phoneNumber',
      );

      await repository.addTransaction(
        date: DateTime.now(),
        beneficiary: beneficiary,
        topUpValue: topUpValue,
        isUserVerified: true,
      );

      final result = await repository.addTransaction(
        date: DateTime.now(),
        beneficiary: beneficiary,
        topUpValue: topUpValue,
        isUserVerified: true,
      );

      expect(result.isLeft(), true);
      expect(result, equals(Left(LimitExceededTotalPerMonthFailure())));
    });
  });

  group('transaction month limit exceeded', () {
    test('should return true when transaction month limit exceeded', () {
      final transactions = [
        TopUpTransaction(
          date: DateTime.now(),
          value: 100,
          beneficiary: const Beneficiary(
            nickName: 'nickname',
            phoneNumber: 'phoneNumber',
          ),
        ),
        TopUpTransaction(
          date: DateTime.now(),
          value: 100,
          beneficiary: const Beneficiary(
            nickName: 'nickname',
            phoneNumber: 'phoneNumber',
          ),
        ),
      ];

      final result = repository.isTransactionMonthLimitExceeded(
        transactions,
        GlobalConstants.maxTopUpPerMonth,
      );

      expect(result, true);
    });

    test('should return false when transaction month limit not exceeded', () {
      final transactions = [
        TopUpTransaction(
          date: DateTime.now(),
          value: 0,
          beneficiary: const Beneficiary(
            nickName: 'nickname',
            phoneNumber: 'phoneNumber',
          ),
        ),
      ];

      final result = repository.isTransactionMonthLimitExceeded(
        transactions,
        GlobalConstants.maxTopUpPerMonth,
      );

      expect(result, false);
    });
  });

  group('isTransactionByBeneficiaryPerMonthLimitExceeded', () {
    test(
        'should return true when transaction by beneficiary per month limit exceeded',
        () {
      final transactions = [
        TopUpTransaction(
          date: DateTime.now(),
          value: GlobalConstants.maxTopUpPerMonthPerBeneficiaryVerified,
          beneficiary: const Beneficiary(
            nickName: 'nickname',
            phoneNumber: 'phoneNumber',
          ),
        ),
        TopUpTransaction(
          date: DateTime.now(),
          value: GlobalConstants.maxTopUpPerMonthPerBeneficiaryVerified,
          beneficiary: const Beneficiary(
            nickName: 'nickname',
            phoneNumber: 'phoneNumber',
          ),
        ),
      ];

      final result = repository.isTransactionByBeneficiaryPerMonthLimitExceeded(
        transactions,
        true,
        const Beneficiary(
          nickName: 'nickname',
          phoneNumber: 'phoneNumber',
        ),
        100,
      );

      expect(result, true);
    });

    test(
        'should return false when transaction by beneficiary per month limit not exceeded',
        () {
      final transactions = [
        TopUpTransaction(
          date: DateTime.now(),
          value: 0,
          beneficiary: const Beneficiary(
            nickName: 'nickname',
            phoneNumber: 'phoneNumber',
          ),
        ),
      ];

      final result = repository.isTransactionByBeneficiaryPerMonthLimitExceeded(
        transactions,
        true,
        const Beneficiary(
          nickName: 'nickname',
          phoneNumber: 'phoneNumber',
        ),
        100,
      );

      expect(result, false);
    });
  });
}
