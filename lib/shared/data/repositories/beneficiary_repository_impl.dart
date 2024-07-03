import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl implements BeneficiaryRepository {
  final BehaviorSubject<List<Beneficiary>> _beneficiariesStreamController =
      BehaviorSubject<List<Beneficiary>>();

  @override
  List<Beneficiary>? get beneficiaries =>
      _beneficiariesStreamController.valueOrNull;

  @override
  Stream<List<Beneficiary>> get beneficiariesStream =>
      _beneficiariesStreamController.stream;

  @override
  Future<Either<Failure, void>> addBeneficiary({
    required String nickname,
    required String phoneNumber,
  }) async {
    final newBeneficiary = Beneficiary(
      nickName: nickname,
      phoneNumber: phoneNumber,
    );

    final currentBeneficiaries = _beneficiariesStreamController.valueOrNull;

    if (currentBeneficiaries != null) {
      final beneficiaryExists = currentBeneficiaries.any((beneficiary) =>
          beneficiary.nickName == newBeneficiary.nickName ||
          beneficiary.phoneNumber == newBeneficiary.phoneNumber);

      if (beneficiaryExists) {
        return Left(AlreadyExistsFailure());
      }

      if (currentBeneficiaries.length >=
          GlobalConstants.maxBeneficiariesCount) {
        return Left(LimitExceededFailure());
      }

      _beneficiariesStreamController
          .add([...currentBeneficiaries, newBeneficiary]);
    } else {
      _beneficiariesStreamController.add([newBeneficiary]);
    }

    return const Right(null);
  }
}
