import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String tokenKey = "jwt_token";
  static const String userIdentifierKey = "user_identifier";

  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: tokenKey);
  }

  Future<void> saveUserIdentifier(String value) async {
    await _storage.write(key: userIdentifierKey, value: value);
  }

  Future<String?> getUserIdentifier() async {
    return await _storage.read(key: userIdentifierKey);
  }

  Future<void> clearData() async {
    await _storage.deleteAll();
  }
}
