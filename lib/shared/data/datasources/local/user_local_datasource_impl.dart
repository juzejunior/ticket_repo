import 'dart:convert';

import 'package:top_up_ticket/core/enums/secure_storage_enum.dart';
import 'package:top_up_ticket/core/secure_storage/secure_storage_manager.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource.dart';
import 'package:top_up_ticket/shared/data/models/user_model.dart';

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SecureStorageManager storage;

  UserLocalDatasourceImpl(
    this.storage,
  );

  @override
  Future<void> cacheUser(UserModel user) async {
    await storage.write(
      key: SecureStorageVariables.user,
      value: jsonEncode(user.toJson()),
    );
  }

  @override
  Future<UserModel?> getUser() async {
    final user = await storage.read(key: SecureStorageVariables.user);

    if (user != null) {
      try {
        final mapUser = jsonDecode(user);
        return UserModel.fromJson(mapUser);
      } catch (e) {
        return null;
      }
    }

    return null;
  }
}
