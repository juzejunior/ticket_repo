import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/features/home/view/cubit/home_state.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.userRepository,
  ) : super(const HomeState.initial());

  final UserRepository userRepository;

  Future<void> loadData() async {
    emit(const HomeState.loading());

    final userResult = await userRepository.getUser();

    userResult.fold(
      (error) {
        if (error is NetworkFailure) {
          return emit(const HomeState.networkError());
        }
        return emit(const HomeState.generalError());
      },
      (user) => emit(HomeState.success(user)),
    );
  }
}
