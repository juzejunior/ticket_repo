import 'package:dartz/dartz.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';

abstract interface class UserRepository {
  User? get user;
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, void>> topUpFeeCharge(int value);
}
