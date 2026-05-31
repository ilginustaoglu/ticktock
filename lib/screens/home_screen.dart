import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/home_tab_provider.dart';
import 'calendar_screen.dart';
import 'lists_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> _tabs = [
    ListsScreen(),
    CalendarScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final index = ref.watch(homeTabIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: _tabs,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (int i) =>
            ref.read(homeTabIndexProvider.notifier).state = i,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.check_circle_outline),
            selectedIcon: const Icon(Icons.check_circle),
            label: l10n.navLists,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon: const Icon(Icons.calendar_today),
            label: l10n.navCalendar,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
