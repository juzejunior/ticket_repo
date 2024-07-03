import 'package:flutter_test/flutter_test.dart';
import 'package:top_up_ticket/shared/data/repositories/beneficiary_repository_impl.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';

void main() {
  late BeneficiaryRepositoryImpl repository;

  setUp(() {
    repository = BeneficiaryRepositoryImpl();
  });

  group('addBeneficiary', () {
    test('should add beneficiary to the stream', () async {
      const nickname = 'nickname';
      const phoneNumber = 'phoneNumber';

      final result = await repository.addBeneficiary(
        nickname: nickname,
        phoneNumber: phoneNumber,
      );

      expect(result.isRight(), true);
      expect(repository.beneficiaries!.length, 1);
      expect(repository.beneficiaries!.first.nickName, nickname);
      expect(repository.beneficiaries!.first.phoneNumber, phoneNumber);
    });

    test('should return AlreadyExistsFailure when beneficiary already exists',
        () async {
      const nickname = 'nickname';
      const phoneNumber = 'phoneNumber';

      await repository.addBeneficiary(
        nickname: nickname,
        phoneNumber: phoneNumber,
      );

      final result = await repository.addBeneficiary(
        nickname: nickname,
        phoneNumber: phoneNumber,
      );

      expect(result.isLeft(), true);
    });

    test('should return LimitExceededFailure when beneficiaries count exceeds',
        () async {
      for (var i = 0; i < GlobalConstants.maxBeneficiariesCount; i++) {
        await repository.addBeneficiary(
          nickname: 'nickname$i',
          phoneNumber: 'phoneNumber$i',
        );
      }

      final result = await repository.addBeneficiary(
        nickname: 'nickname',
        phoneNumber: 'phoneNumber',
      );

      expect(result.isLeft(), true);
    });
  });
}
