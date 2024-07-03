import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_beneficiary_state.freezed.dart';

@freezed
sealed class AddBeneficiaryState with _$AddBeneficiaryState {
  const factory AddBeneficiaryState.initial() = _Initial;
  const factory AddBeneficiaryState.loading() = LoadingState;
  const factory AddBeneficiaryState.alreadyExists() = AlreadyExistsState;
  const factory AddBeneficiaryState.fieldMissing() = FieldMissingState;
  const factory AddBeneficiaryState.maxBeneficiariesReached() =
      MaxBeneficiariesReachedState;
  const factory AddBeneficiaryState.generalError() = GeneralErrorState;
  const factory AddBeneficiaryState.success() = SuccessState;
}
