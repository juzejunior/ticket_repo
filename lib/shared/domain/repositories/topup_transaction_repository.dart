import 'package:dartz/dartz.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/entities/topup_transaction.dart';

abstract interface class TopupTransactionRepository {
  Stream<List<TopUpTransaction>> get transactionsStream;
  List<TopUpTransaction>? get transactions;
  Future<Either<Failure, void>> addTransaction({
    required DateTime date,
    required Beneficiary beneficiary,
    required int topUpValue,
    required bool isUserVerified,
  });
}
