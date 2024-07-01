import 'package:freezed_annotation/freezed_annotation.dart';

part 'beneficiary.freezed.dart';

@freezed
class Beneficiary with _$Beneficiary {
  const factory Beneficiary({
    required String id,
    required String nickName,
    required String phoneNumber,
  }) = _Beneficiary;
}
