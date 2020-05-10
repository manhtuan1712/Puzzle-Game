
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const String API_TOKEN = "apiToken";
  static const String FCM_TOKEN = "fcmToken";
  static const String IS_FIRST_TIME = "is_first_time";
  static const String PROFILE_CUSTOMER = "profile_customer";
  static const String WIFI_INFO = "wifi_info";

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String> get apiToken async =>
      await _secureStorage.read(key: API_TOKEN);

  Future<String> get fcmToken async =>
      await _secureStorage.read(key: FCM_TOKEN);

  saveApiToken(String token) async {
    await _secureStorage.write(key: API_TOKEN, value: token);
  }

  saveFcmToken(String fcmToken) async {
    await _secureStorage.write(key: API_TOKEN, value: fcmToken);
  }

  deleteAllSS() async {
    await _secureStorage.deleteAll();
  }

  deleteToken() async {
    await _secureStorage.delete(key: API_TOKEN);
  }

  Future<String> getCustomString(String key) async =>
      await _secureStorage.read(key: key);

  saveCustomString(String key, String data) async {
    await _secureStorage.write(key: key, value: data);
  }

  removeCustomString(String key) async {
    await _secureStorage.delete(key: key);
  }
}
