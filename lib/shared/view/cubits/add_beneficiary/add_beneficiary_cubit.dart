import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/view/cubits/add_beneficiary/add_beneficiary_state.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';

class AddBeneficiaryCubit extends Cubit<AddBeneficiaryState> {
  AddBeneficiaryCubit({
    required this.beneficiaryRepository,
  }) : super(const AddBeneficiaryState.initial());

  final BeneficiaryRepository beneficiaryRepository;

  void addBeneficiary(
      {required String nickname, required String phoneNumber}) async {
    emit(const AddBeneficiaryState.loading());

    if (nickname.isEmpty || phoneNumber.isEmpty) {
      emit(const AddBeneficiaryState.fieldMissing());
      return;
    }

    final result = await beneficiaryRepository.addBeneficiary(
      nickname: nickname,
      phoneNumber: phoneNumber,
    );

    result.fold(
      (error) {
        if (error is AlreadyExistsFailure) {
          emit(const AddBeneficiaryState.alreadyExists());
          return;
        }

        if (error is LimitExceededFailure) {
          emit(const AddBeneficiaryState.maxBeneficiariesReached());
          return;
        }

        emit(const AddBeneficiaryState.generalError());
      },
      (_) => emit(const AddBeneficiaryState.success()),
    );
  }
}
