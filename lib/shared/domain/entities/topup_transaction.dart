import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';

part 'topup_transaction.freezed.dart';

@freezed
class TopUpTransaction with _$TopUpTransaction {
  const factory TopUpTransaction({
    required DateTime date,
    required int value,
    required Beneficiary beneficiary,
  }) = _TopUpTransaction;
}
