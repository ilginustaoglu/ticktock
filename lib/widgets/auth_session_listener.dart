import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/database/supabase_service.dart';
import '../providers/auth_provider.dart' show authProvider, AuthStatus;
import '../providers/data_sync.dart';
import '../screens/home_screen.dart';

/// Deep link ile e-posta onayı tamamlanınca oturumu ve veriyi günceller.
class AuthSessionListener extends ConsumerStatefulWidget {
  const AuthSessionListener({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  ConsumerState<AuthSessionListener> createState() => _AuthSessionListenerState();
}

class _AuthSessionListenerState extends ConsumerState<AuthSessionListener> {
  @override
  void initState() {
    super.initState();
    if (SupabaseService.isReady) {
      SupabaseService.client.auth.onAuthStateChange.listen(_onAuthChange);
    }
  }

  Future<void> _onAuthChange(AuthState data) async {
    if (data.event == AuthChangeEvent.signedIn && data.session != null) {
      await ref.read(authProvider.notifier).refreshFromSession();
      await reloadUserData(ref);
      final auth = ref.read(authProvider);
      if (auth.status == AuthStatus.authenticated) {
        widget.navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
          (_) => false,
        );
      }
    }
    if (data.event == AuthChangeEvent.signedOut) {
      await ref.read(authProvider.notifier).refreshFromSession();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
