import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:top_up_ticket/shared/data/models/user_model.dart';

void main() {
  late UserRemoteDatasourceImpl dataSource;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    dataSource = UserRemoteDatasourceImpl();
  });

  group('getUser', () {
    test('should return user model', () async {
      final result = await dataSource.getUser();
      expect(result, isNotNull);
      expect(result, isA<UserModel>());
    });
  });
}
