import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: 'access', value: accessToken);
    await _secureStorage.write(key: 'refresh', value: refreshToken);
  }

  Future<void> saveUserId(String userId) async {
    await _secureStorage.write(key: 'user_id', value: userId);
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userData = await _secureStorage.readAll();
    return userData;
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    for (var entry in userData.entries) {
      await _secureStorage.write(key: entry.key, value: entry.value.toString());
    }
  }

  Future<void> clearUserData() async {
    await _secureStorage.deleteAll();
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access');
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh');
  }

  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: 'access');
    await _secureStorage.delete(key: 'refresh');
  }
}
