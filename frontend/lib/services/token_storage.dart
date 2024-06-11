import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: 'access', value: accessToken);
    await _secureStorage.write(key: 'refresh', value: refreshToken);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(key: 'access', value: accessToken);
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
