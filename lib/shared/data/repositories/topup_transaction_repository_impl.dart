import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/core/network/connection_status.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/topup_transaction_remote_datasource.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/entities/topup_transaction.dart';
import 'package:top_up_ticket/shared/domain/repositories/topup_transaction_repository.dart';

class TopupTransactionRepositoryImpl implements TopupTransactionRepository {
  final TopupTransactionRemoteDatasource dataSource;
  final ConnectionStatus connectionStatus;

  final BehaviorSubject<List<TopUpTransaction>> _transactionsStreamController =
      BehaviorSubject<List<TopUpTransaction>>();

  TopupTransactionRepositoryImpl({
    required this.dataSource,
    required this.connectionStatus,
  });

  @override
  Future<Either<Failure, void>> addTransaction({
    required DateTime date,
    required Beneficiary beneficiary,
    required int topUpValue,
    required bool isUserVerified,
  }) async {
    final newTransaction = TopUpTransaction(
      date: date,
      value: topUpValue,
      beneficiary: beneficiary,
    );

    try {
      if (await connectionStatus.isConnected) {
        final currentTransactions = _transactionsStreamController.valueOrNull;

        if (currentTransactions != null) {
          if (isTransactionMonthLimitExceeded(
              currentTransactions, topUpValue)) {
            return Left(LimitExceededTotalPerMonthFailure());
          }

          if (isTransactionByBeneficiaryPerMonthLimitExceeded(
              currentTransactions, isUserVerified, beneficiary, topUpValue)) {
            return Left(LimitExceededTotalPerMonthPerBeneficiaryFailure());
          }

          await dataSource.addTopupTransaction(
            value: topUpValue,
            phoneNumber: beneficiary.phoneNumber,
          );

          _transactionsStreamController
              .add([...currentTransactions, newTransaction]);
        } else {
          _transactionsStreamController.add([newTransaction]);
        }
        return const Right(null);
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  bool isTransactionMonthLimitExceeded(
      List<TopUpTransaction> transactions, int topUpValue) {
    final currentMonthTransactions = transactions
        .where((transaction) =>
            transaction.date.month == DateTime.now().month &&
            transaction.date.year == DateTime.now().year)
        .toList();
    final totalValue = currentMonthTransactions.fold<int>(
        0, (sum, transaction) => sum + transaction.value);
    return (totalValue + topUpValue) > GlobalConstants.maxTopUpPerMonth;
  }

  bool isTransactionByBeneficiaryPerMonthLimitExceeded(
    List<TopUpTransaction> transactions,
    bool isUserVerified,
    Beneficiary beneficiary,
    int topUpValue,
  ) {
    final currentMonthTransactions = transactions
        .where((transaction) =>
            transaction.date.day == DateTime.now().day &&
            transaction.date.month == DateTime.now().month &&
            transaction.date.year == DateTime.now().year &&
            beneficiary == transaction.beneficiary)
        .toList();

    final totalValue = currentMonthTransactions.fold<int>(
        0, (sum, transaction) => sum + transaction.value);

    if (isUserVerified) {
      return totalValue >
          GlobalConstants.maxTopUpPerMonthPerBeneficiaryVerified;
    }

    return (totalValue + topUpValue) >
        GlobalConstants.maxTopUpPerMonthPerBeneficiaryNotVerified;
  }

  @override
  List<TopUpTransaction>? get transactions =>
      _transactionsStreamController.valueOrNull;

  @override
  Stream<List<TopUpTransaction>> get transactionsStream =>
      _transactionsStreamController.stream;
}
