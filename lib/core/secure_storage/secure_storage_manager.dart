import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_up_ticket/core/enums/secure_storage_enum.dart';

class SecureStorageManager {
  SecureStorageManager(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<void> write(
          {required SecureStorageVariables key, required String value}) =>
      _secureStorage.write(key: key.name, value: value);

  Future<String?> read({required SecureStorageVariables key}) =>
      _secureStorage.read(key: key.name);

  Future<void> delete({required SecureStorageVariables key}) =>
      _secureStorage.delete(key: key.name);
}
