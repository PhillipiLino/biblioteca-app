import 'dart:convert';

import 'package:commons_tools_sdk/preferences.dart';

class PreferencesManager {
  final IPreferences _preferences;

  PreferencesManager(this._preferences);

  Future<String?> getString(String key) async {
    try {
      return await _preferences.getString(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> setString(String key, String value) async {
    try {
      return await _preferences.setString(key, value);
    } catch (e) {
      return false;
    }
  }

  Future<int?> getInt(String key) async {
    try {
      return await _preferences.getInt(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> setInt(String key, int value) async {
    try {
      return await _preferences.setInt(key, value);
    } catch (e) {
      return false;
    }
  }

  Future<bool?> getBool(String key) async {
    try {
      return await _preferences.getBool(key);
    } catch (e) {
      return null;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    try {
      return await _preferences.setBool(key, value);
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getDict(String key) async {
    try {
      final jsonString = await _preferences.getString(key);
      return jsonString == null ? null : jsonDecode(jsonString);
    } catch (e) {
      return null;
    }
  }

  Future<bool> setDict(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await _preferences.setString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  Future<List<String>?> getKeys() async {
    try {
      return await _preferences.getKeys();
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeKey(String key) async {
    try {
      return await _preferences.removeKey(key);
    } catch (e) {
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      return await _preferences.clear();
    } catch (e) {
      return false;
    }
  }
}
