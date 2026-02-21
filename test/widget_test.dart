// Flutter widget tests.
// Run: flutter test test/widget_test.dart
//
// Not: Tam uygulama testi Hive/path_provider gerektirdiği için
// gerçek cihazda integration test ile yapılır. Burada sadece
// storage kullanmayan widget'lar test ediliyor.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ticktock/providers/theme_mode_provider.dart';
import 'package:ticktock/widgets/theme_mode_button.dart';

void main() {
  group('ThemeModeButton', () {
    testWidgets('opens theme menu and shows Light, Dark, System', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeModeProvider.overrideWith((ref) => _TestThemeModeNotifier()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: ThemeModeButton(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<ThemeMode>));
      await tester.pumpAndSettle();

      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('System'), findsOneWidget);
    });
  });
}

/// Test için: storage kullanmadan sabit ThemeMode döner.
class _TestThemeModeNotifier extends ThemeModeNotifier {
  _TestThemeModeNotifier() : super() {
    state = ThemeMode.system;
  }

  @override
  void load() {}
}
