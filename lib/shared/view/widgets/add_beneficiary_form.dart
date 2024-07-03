import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';
import 'package:top_up_ticket/shared/view/cubits/add_beneficiary/add_beneficiary_cubit.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';
import 'package:top_up_ticket/shared/view/cubits/add_beneficiary/add_beneficiary_state.dart';
import 'package:top_up_ticket/shared/view/widgets/top_up_snackbar.dart';

class AddBeneficiaryForm extends StatefulWidget {
  const AddBeneficiaryForm({super.key});

  @override
  State<AddBeneficiaryForm> createState() => _AddBeneficiaryFormState();
}

class _AddBeneficiaryFormState extends State<AddBeneficiaryForm> {
  late TextEditingController nicknameController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    nicknameController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBeneficiaryCubit(
        beneficiaryRepository: context.read<BeneficiaryRepository>(),
      ),
      child: BlocConsumer<AddBeneficiaryCubit, AddBeneficiaryState>(
        listener: _listenToState,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Add Beneficiary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _BeneficiaryForm(
                    nicknameController: nicknameController,
                    phoneNumberController: phoneNumberController,
                    isLoading: state is LoadingState,
                    onAddBeneficiary: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<AddBeneficiaryCubit>().addBeneficiary(
                            nickname: nicknameController.text,
                            phoneNumber: phoneNumberController.text,
                          );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _listenToState(BuildContext context, AddBeneficiaryState state) {
    switch (state) {
      case LoadingState():
        break;
      case AlreadyExistsState():
        TopUpSnackbar.showFailure(
            context, 'Nickname or phonenumber already exists');
        break;
      case FieldMissingState():
        TopUpSnackbar.showFailure(context, 'Please fill in all fields');
        break;
      case MaxBeneficiariesReachedState():
        TopUpSnackbar.showFailure(context,
            'Max of ${GlobalConstants.maxBeneficiariesCount} beneficiaries reached');
        break;
      case GeneralErrorState():
        TopUpSnackbar.showFailure(
            context, 'Something went wrong. Please try again');
        break;
      case SuccessState():
        TopUpSnackbar.showSuccess(context, 'Beneficiary added successfully');
        Navigator.of(context).pop();
        break;
      default:
        break;
    }
  }
}

class _BeneficiaryForm extends StatelessWidget {
  const _BeneficiaryForm({
    this.onAddBeneficiary,
    required this.nicknameController,
    required this.phoneNumberController,
    required this.isLoading,
  });

  final VoidCallback? onAddBeneficiary;
  final TextEditingController nicknameController;
  final TextEditingController phoneNumberController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname*',
                ),
                maxLength: 20,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number*',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  PhoneInputFormatter(
                    allowEndlessPhone: true,
                    defaultCountryCode: 'AE',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onAddBeneficiary,
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator.adaptive())
                  : const Text('Add Beneficiary'),
            ),
          ),
        ],
      ),
    );
  }
}
