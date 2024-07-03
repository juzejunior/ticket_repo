import 'package:equatable/equatable.dart';
import 'package:top_up_ticket/features/top_up/domain/entities/top_up.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';

class TopUpState extends Equatable {
  final User? user;
  final List<TopUp>? topUps;
  final int? selectedTopUp;
  final bool? isLoading;
  final bool? hasError;

  bool get isValid => user != null && selectedTopUp != null;

  const TopUpState({
    this.user,
    this.topUps,
    this.selectedTopUp,
    this.isLoading = false,
    this.hasError = false,
  });

  copyWith({
    User? user,
    List<TopUp>? topUps,
    int? selectedTopUp,
    bool? isLoading,
    bool? hasError,
  }) {
    return TopUpState(
      user: user ?? this.user,
      topUps: topUps ?? this.topUps,
      selectedTopUp: selectedTopUp ?? this.selectedTopUp,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [
        user,
        topUps,
        selectedTopUp,
        isLoading,
        hasError,
      ];
}
