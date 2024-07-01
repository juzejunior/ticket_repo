import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_ticket/shared/domain/entities/beneficiary.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';

part 'mobile_recharge_state.freezed.dart';

@freezed
sealed class MobileRechargeState with _$MobileRechargeState {
  const factory MobileRechargeState.initial() = _Initial;
  const factory MobileRechargeState.loading() = LoadingState;
  const factory MobileRechargeState.networkError() = NetworkErrorState;
  const factory MobileRechargeState.generalError() = GeneralErrorState;
  const factory MobileRechargeState.success(
    User user,
    List<Beneficiary> beneficiaries,
  ) = SuccessState;
}
