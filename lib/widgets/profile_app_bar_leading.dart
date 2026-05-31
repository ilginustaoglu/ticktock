import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/home_tab_provider.dart';
import 'profile_avatar.dart';

/// AppBar sol köşesinde profil resmi; tıklanınca profil sekmesine gider.
class ProfileAppBarLeading extends ConsumerWidget {
  const ProfileAppBarLeading({super.key});

  static const int profileTabIndex = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(authProvider).user;

    return IconButton(
      onPressed: () {
        ref.read(homeTabIndexProvider.notifier).state = profileTabIndex;
      },
      icon: ProfileAvatar(user: user, radius: 18),
      tooltip: l10n.navProfile,
    );
  }
}
