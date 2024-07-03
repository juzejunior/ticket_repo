import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/features/top_up/domain/entities/top_up.dart';
import 'package:top_up_ticket/features/top_up/view/cubit/top_up_state.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class TopUpCubit extends Cubit<TopUpState> {
  TopUpCubit({required this.userRepository}) : super(const TopUpState()) {
    _loadData();
  }

  final UserRepository userRepository;

  final List<TopUp> topUps = [
    const TopUp(value: 5, label: 'AED 5'),
    const TopUp(value: 10, label: 'AED 10'),
    const TopUp(value: 20, label: 'AED 20'),
    const TopUp(value: 30, label: 'AED 30'),
    const TopUp(value: 50, label: 'AED 50'),
    const TopUp(value: 75, label: 'AED 75'),
    const TopUp(value: 100, label: 'AED 100'),
  ];

  Future<void> _loadData() async {
    emit(state.copyWith(isLoading: true));

    final userResult = await userRepository.getUser();

    userResult.fold(
      (error) {
        return emit(state.copyWith(
          hasError: true,
          isLoading: false,
        ));
      },
      (user) => emit(state.copyWith(
        user: user,
        topUps: topUps,
        isLoading: false,
        hasError: false,
      )),
    );
  }

  void selectTopUp(int? value) {
    emit(state.copyWith(selectedTopUp: value));
  }
}
