
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


enum StorageKeys {
  auth_token,
}


class StorageProvider {
  static final storage = FlutterSecureStorage();

  static Future add ({required StorageKeys key, required String value}) async {
    return await storage.write(key: key.name, value: value);
  }

  static Future<bool> exists({required StorageKeys key}) async {
    return await storage.containsKey(key: key.name);
  }

  static Future<String?> get ({required StorageKeys key}) async {
    return await storage.read(key: key.name);
  }

  static Future delete ({required StorageKeys key}) async {
    return await storage.delete(key: key.name);
  }

}

