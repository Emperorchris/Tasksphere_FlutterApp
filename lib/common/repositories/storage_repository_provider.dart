import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorageRepository>((
  ref,
) {
  return FlutterSecureStorageRepository(storage: FlutterSecureStorage());
});

class FlutterSecureStorageRepository {
  final FlutterSecureStorage storage;
  FlutterSecureStorageRepository({required this.storage});

  Future<String?> getValue(String key) async {
    return await storage.read(key: key);
  }

  Future<void> setValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteValue(String key) async {
    await storage.delete(key: key);
  }
}




class StorageKeys {
  static const userId = 'userId';
  static const accessToken = 'accessToken';
}