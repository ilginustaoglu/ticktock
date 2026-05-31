import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/theme_mode_provider.dart';

/// App bar sağ köşesinde tema seçimi (Light / Dark / System).
class ThemeModeButton extends ConsumerWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    return PopupMenuButton<ThemeMode>(
      icon: Icon(
        themeMode == ThemeMode.dark
            ? Icons.dark_mode
            : themeMode == ThemeMode.light
                ? Icons.light_mode
                : Icons.brightness_auto,
      ),
      tooltip: l10n.theme,
      onSelected: (mode) => ref.read(themeModeProvider.notifier).set(mode),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ThemeMode.light,
          child: Row(
            children: [
              Icon(Icons.light_mode, size: 20, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(width: 12),
              Text(l10n.light),
            ],
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.dark,
          child: Row(
            children: [
              Icon(Icons.dark_mode, size: 20, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(width: 12),
              Text(l10n.dark),
            ],
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(Icons.brightness_auto, size: 20, color: Theme.of(context).colorScheme.onSurface),
              const SizedBox(width: 12),
              Text(l10n.system),
            ],
          ),
        ),
      ],
    );
  }
}
