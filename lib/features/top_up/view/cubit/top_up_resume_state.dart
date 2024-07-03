import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_up_resume_state.freezed.dart';

@freezed
sealed class TopUpResumeState with _$TopUpResumeState {
  const factory TopUpResumeState.initial() = _Initial;
  const factory TopUpResumeState.loading() = LoadingState;
  const factory TopUpResumeState.networkError() = NetworkErrorState;
  const factory TopUpResumeState.generalError() = GeneralErrorState;
  const factory TopUpResumeState.monthLimitExceeded() = MonthLimitExceededState;
  const factory TopUpResumeState.monthLimitPerBeneficiaryExceeded() =
      MonthLimitPerBeneficiaryExceededState;
  const factory TopUpResumeState.insufficientBalance() =
      InsufficientBalanceState;
  const factory TopUpResumeState.success() = SuccessState;
}
