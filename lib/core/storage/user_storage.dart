import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user.dart';

const String _userBoxName = 'ticktock_user_data';
const String _keyUsers = 'users';
const String _keyCurrentUserId = 'current_user_id';
const String _keyLocale = 'locale';

class UserStorage {
  static late Box<dynamic> _box;

  static Future<void> init() async {
    _box = await Hive.openBox<dynamic>(_userBoxName);
  }

  static List<User> getUsers() {
    final raw = _box.get(_keyUsers);
    if (raw == null || raw is! List) return [];
    return (raw as List)
        .map((e) => User.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  static Future<void> saveUsers(List<User> users) async {
    await _box.put(_keyUsers, users.map((e) => e.toJson()).toList());
  }

  static String? getCurrentUserId() {
    final v = _box.get(_keyCurrentUserId);
    return v is String ? v : null;
  }

  static Future<void> setCurrentUserId(String? userId) async {
    if (userId == null) {
      await _box.delete(_keyCurrentUserId);
    } else {
      await _box.put(_keyCurrentUserId, userId);
    }
  }

  static String getLocale() {
    final v = _box.get(_keyLocale);
    if (v is String) return v;
    return 'en';
  }

  static Future<void> saveLocale(String localeCode) async {
    await _box.put(_keyLocale, localeCode);
  }
}
