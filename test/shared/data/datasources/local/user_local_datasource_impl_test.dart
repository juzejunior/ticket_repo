import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_up_ticket/core/enums/secure_storage_enum.dart';
import 'package:top_up_ticket/core/secure_storage/secure_storage_manager.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource_impl.dart';
import 'package:top_up_ticket/shared/data/models/user_model.dart';

class MockSecureStorageManager extends Mock implements SecureStorageManager {}

void main() {
  late UserLocalDatasourceImpl dataSource;
  late SecureStorageManager storage;

  setUp(() {
    storage = MockSecureStorageManager();
    dataSource = UserLocalDatasourceImpl(storage);
  });

  group('cacheUser', () {
    test('should call storage.write with correct value', () async {
      when(() => storage.write(
          key: SecureStorageVariables.user,
          value: any(named: 'value'))).thenAnswer((_) async => Future.value());

      final tUser = UserModel(
        id: 'eresra',
        name: 'teste',
        isVerified: true,
        balance: 12,
      );
      await dataSource.cacheUser(tUser);
      verify(
        () => storage.write(
            key: SecureStorageVariables.user, value: any(named: 'value')),
      );
    });
  });

  group('getUser', () {
    test('should return user model', () async {
      when(() => storage.read(key: SecureStorageVariables.user))
          .thenAnswer((_) async => jsonEncode({
                'id': 'eresra',
                'name': 'teste',
                'isVerified': true,
                'balance': 12,
              }));

      final result = await dataSource.getUser();
      expect(result, isNotNull);
      expect(result, isA<UserModel>());
    });

    test('should return null when user is null', () async {
      when(() => storage.read(key: SecureStorageVariables.user))
          .thenAnswer((_) async => null);

      final result = await dataSource.getUser();
      expect(result, isNull);
    });

    test('should return null when user is invalid', () async {
      when(() => storage.read(key: SecureStorageVariables.user))
          .thenAnswer((_) async => 'invalid');

      final result = await dataSource.getUser();
      expect(result, isNull);
    });
  });
}
