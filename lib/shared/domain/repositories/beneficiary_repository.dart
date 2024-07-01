import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';

abstract interface class BeneficiaryRepository {
  Stream<List<Beneficiary>> get beneficiariesStream;
  List<Beneficiary>? get beneficiaries;
}
