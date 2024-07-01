import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = LoadingState;
  const factory HomeState.networkError() = NetworkErrorState;
  const factory HomeState.generalError() = GeneralErrorState;
  const factory HomeState.success(
    User user,
  ) = SuccessState;
}
