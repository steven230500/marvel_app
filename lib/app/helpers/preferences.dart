import 'package:marvel_app/app/contants/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarvelPreferences {
  const MarvelPreferences({
    required SharedPreferences sharedPreferences,
  }) : _preferences = sharedPreferences;

  final SharedPreferences _preferences;

  String get authToken => _preferences.getString(SharedPrefKeys.authToken) ?? '';
  void setAuthToken(String value) => _preferences.setString(SharedPrefKeys.authToken, value);

  String get sessionId => _preferences.getString(SharedPrefKeys.sessionId) ?? '';

  void setSessionId(String value) => _preferences.setString(SharedPrefKeys.sessionId, value);

  void clear() {
    _preferences.clear();
  }
}
