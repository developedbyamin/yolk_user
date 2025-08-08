import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokens {
  final String accessToken;
  final String refreshToken;
  AuthTokens({required this.accessToken, required this.refreshToken});
}

class SecureStorage {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> saveTokens(AuthTokens tokens) async {
    try {
      await _secureStorage.write(key: 'accessToken', value: tokens.accessToken);
      await _secureStorage.write(key: 'refreshToken', value: tokens.refreshToken);
      debugPrint("Tokens saved: ${tokens.accessToken}, ${tokens.refreshToken}");
    } catch (e) {
      debugPrint('Error saving tokens: $e');
    }
  }

  static Future<AuthTokens?> getTokens() async {
    try {
      String? accessToken = await _secureStorage.read(key: 'accessToken');
      String? refreshToken = await _secureStorage.read(key: 'refreshToken');
      if (refreshToken != null && accessToken != null) {
        return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
      }
    } catch (e) {
      debugPrint('Error reading tokens: $e');
    }
    return null;
  }

  static Future<void> deleteTokens() async {
    try {
      await _secureStorage.delete(key: 'accessToken');
      await _secureStorage.delete(key: 'refreshToken');
      debugPrint("Tokens deleted");
    } catch (e) {
      debugPrint('Error deleting tokens: $e');
    }
  }
}
