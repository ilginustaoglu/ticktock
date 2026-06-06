import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'calendar_provider.dart';
import 'locale_provider.dart';
import 'theme_mode_provider.dart';
import 'todo_provider.dart';

/// Oturum açıldıktan veya kapandıktan sonra kullanıcı verisini yeniden yükler.
Future<void> reloadUserData(WidgetRef ref) async {
  await Future.wait([
    ref.read(todoListsProvider.notifier).load(),
    ref.read(todoItemsProvider.notifier).load(),
    ref.read(calendarEventsProvider.notifier).load(),
    ref.read(themeModeProvider.notifier).load(),
    ref.read(localeProvider.notifier).load(),
  ]);
}
