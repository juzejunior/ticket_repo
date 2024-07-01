import 'package:dartz/dartz.dart';
import 'package:top_up_ticket/core/error/exception.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/core/network/connection_status.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource.dart';
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

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final user = await localDataSource.getUser();

      if (user != null) {
        return Right(user.toEntity);
      }

      if (await connectionStatus.isConnected) {
        final user = await remoteDataSource.getUser();
        await localDataSource.cacheUser(user);
        return Right(user.toEntity);
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
}
