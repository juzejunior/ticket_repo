import 'package:dartz/dartz.dart';
import 'package:top_up_ticket/core/error/exception.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/core/network/connection_status.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource.dart';
import 'package:top_up_ticket/shared/domain/constants/global_constants.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDataSource;
  final UserLocalDatasource localDataSource;
  final ConnectionStatus connectionStatus;

  UserRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.connectionStatus,
  );

  User? _user;

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      if (user != null) {
        return Right(user!);
      }

      final userData = await localDataSource.getUser();

      if (userData != null) {
        _user = userData.toEntity;
        return Right(user!);
      }

      if (await connectionStatus.isConnected) {
        final userModel = await remoteDataSource.getUser();
        await localDataSource.cacheUser(userModel);
        _user = userModel.toEntity;
        return Right(user!);
      } else {
        throw NetworkException();
      }
    } catch (e) {
      if (e is NetworkException) {
        return Left(NetworkFailure());
      }

      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> topUpFeeCharge(int value) async {
    try {
      final totalValue = value + GlobalConstants.topUpFee;
      if (_user!.balance < totalValue) {
        return Left(InsufficientBalanceFailure());
      }

      if (await connectionStatus.isConnected) {
        await remoteDataSource.startTopUpTransaction(
          value,
          GlobalConstants.topUpFee,
        );

        _user = _user!.copyWith(
          balance: user!.balance - totalValue,
        );

        return const Right(null);
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      if (e is NetworkException) {
        return Left(NetworkFailure());
      }

      return Left(ServerFailure());
    }
  }

  @override
  User? get user => _user;
}
