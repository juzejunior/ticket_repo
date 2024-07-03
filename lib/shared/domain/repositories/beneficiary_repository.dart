import 'package:dartz/dartz.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';

abstract interface class BeneficiaryRepository {
  Stream<List<Beneficiary>> get beneficiariesStream;
  List<Beneficiary>? get beneficiaries;
  Future<Either<Failure, void>> addBeneficiary(
      {required String nickname, required String phoneNumber});
}
