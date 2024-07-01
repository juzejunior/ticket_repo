import 'package:dartz/dartz.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
}
