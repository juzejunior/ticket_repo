import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_ticket/core/error/failures.dart';
import 'package:top_up_ticket/core/network/connection_status.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource.dart';
import 'package:top_up_ticket/shared/data/models/user_model.dart';
import 'package:top_up_ticket/shared/data/repositories/user_repository_impl.dart';

class MockUserLocalDataSource extends Mock implements UserLocalDatasource {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDatasource {}

class MockConnectionStatus extends Mock implements ConnectionStatus {}

void main() {
  late UserRepositoryImpl repository;
  late UserLocalDatasource localDataSource;
  late UserRemoteDatasource remoteDataSource;
  late ConnectionStatus connectionStatus;

  setUp(() {
    localDataSource = MockUserLocalDataSource();
    remoteDataSource = MockUserRemoteDataSource();
    connectionStatus = MockConnectionStatus();
    repository = UserRepositoryImpl(
      remoteDataSource,
      localDataSource,
      connectionStatus,
    );
  });

  group('getUser', () {
    test('should return user from localDataSource', () async {
      final user = UserModel(
        id: 'id',
        name: 'name',
        isVerified: true,
        balance: 100,
      );

      when(() => localDataSource.getUser()).thenAnswer((_) async => user);

      final result = await repository.getUser();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw Exception()), user.toEntity);
    });

    test('should return user from remoteDataSource', () async {
      final user = UserModel(
        id: 'id',
        name: 'name',
        isVerified: true,
        balance: 100,
      );

      when(() => localDataSource.getUser()).thenAnswer((_) async => null);
      when(() => localDataSource.cacheUser(user))
          .thenAnswer((_) async => Future.value());
      when(() => connectionStatus.isConnected).thenAnswer((_) async => true);
      when(() => remoteDataSource.getUser()).thenAnswer((_) async => user);

      final result = await repository.getUser();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw Exception()), user.toEntity);
    });

    test('should return NetworkFailure when no connection', () async {
      when(() => localDataSource.getUser()).thenAnswer((_) async => null);
      when(() => connectionStatus.isConnected).thenAnswer((_) async => false);

      final result = await repository.getUser();

      expect(result.isLeft(), true);
      expect(result, equals(Left(NetworkFailure())));
    });

    test('should return ServerFailure when exception', () async {
      when(() => localDataSource.getUser()).thenThrow(Exception());

      final result = await repository.getUser();

      expect(result.isLeft(), true);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('topUpFeeCharge', () {
    test('should return Right when top up success', () async {
      final user = UserModel(
        id: 'id',
        name: 'name',
        isVerified: true,
        balance: 200,
      );

      when(() => connectionStatus.isConnected).thenAnswer((_) async => true);
      when(() => remoteDataSource.startTopUpTransaction(
            any(that: equals(100)),
            any(),
          )).thenAnswer((_) async => Future.value());

      when(() => localDataSource.getUser()).thenAnswer((_) async => user);

      await repository.getUser();
      final result = await repository.topUpFeeCharge(100);

      expect(result.isRight(), true);
      expect(result, equals(const Right(null)));
    });

    test('should return InsufficientBalanceFailure when balance not enough',
        () async {
      final user = UserModel(
        id: 'id',
        name: 'name',
        isVerified: true,
        balance: 100,
      );

      when(() => localDataSource.getUser()).thenAnswer((_) async => user);

      await repository.getUser();
      final result = await repository.topUpFeeCharge(200);

      expect(result.isLeft(), true);
      expect(result, equals(Left(InsufficientBalanceFailure())));
    });

    test('should return NetworkFailure when no connection', () async {
      when(() => connectionStatus.isConnected).thenAnswer((_) async => false);

      final user = UserModel(
        id: 'id',
        name: 'name',
        isVerified: true,
        balance: 150,
      );

      when(() => localDataSource.getUser()).thenAnswer((_) async => user);

      await repository.getUser();
      final result = await repository.topUpFeeCharge(100);

      expect(result.isLeft(), true);
      expect(result, equals(Left(NetworkFailure())));
    });

    test('should return ServerFailure when exception', () async {
      when(() => connectionStatus.isConnected).thenAnswer((_) async => true);
      when(() => remoteDataSource.startTopUpTransaction(100, 10))
          .thenThrow(Exception());

      final result = await repository.topUpFeeCharge(100);

      expect(result.isLeft(), true);
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
