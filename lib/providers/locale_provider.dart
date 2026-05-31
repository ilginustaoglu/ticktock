import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/user_storage.dart';
import '../l10n/app_localizations.dart';

const supportedLocaleCodes = ['en', 'tr', 'de', 'es', 'fr', 'it', 'ja', 'zh', 'ko'];

const supportedLocales = [
  Locale('en'),
  Locale('tr'),
  Locale('de'),
  Locale('es'),
  Locale('fr'),
  Locale('it'),
  Locale('ja'),
  Locale('zh'),
  Locale('ko'),
];

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(Locale(UserStorage.getLocale())) {
    final code = UserStorage.getLocale();
    if (supportedLocaleCodes.contains(code)) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(String languageCode) async {
    if (!supportedLocaleCodes.contains(languageCode)) return;
    state = Locale(languageCode);
    await UserStorage.saveLocale(languageCode);
  }
}

String languageLabel(AppLocalizations l10n, String code) {
  switch (code) {
    case 'tr':
      return l10n.languageTurkish;
    case 'de':
      return l10n.languageGerman;
    case 'es':
      return l10n.languageSpanish;
    case 'fr':
      return l10n.languageFrench;
    case 'it':
      return l10n.languageItalian;
    case 'ja':
      return l10n.languageJapanese;
    case 'zh':
      return l10n.languageChinese;
    case 'ko':
      return l10n.languageKorean;
    default:
      return l10n.languageEnglish;
  }
}
