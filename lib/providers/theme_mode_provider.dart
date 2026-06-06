import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/profile_repository.dart';
import '../core/storage/task_storage.dart';
import 'auth_provider.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref)..load();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._ref) : super(ThemeMode.system);

  final Ref _ref;

  String? get _userId => _ref.read(authProvider).user?.id;

  Future<void> load() async {
    if (AuthNotifier.usesRemoteDb && _userId != null) {
      final saved = await ProfileRepository.fetchThemeMode(_userId!);
      state = _themeModeFromString(saved ?? 'system');
      return;
    }
    state = _themeModeFromString(TaskStorage.getThemeMode());
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    final value = _stringFromThemeMode(mode);
    if (AuthNotifier.usesRemoteDb && _userId != null) {
      await ProfileRepository.update(userId: _userId!, themeMode: value);
    } else {
      await TaskStorage.saveThemeMode(value);
    }
  }

  static ThemeMode _themeModeFromString(String s) {
    switch (s) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static String _stringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
