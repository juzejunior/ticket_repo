import 'package:rxdart/rxdart.dart';
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
}
