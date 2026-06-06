import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_config.dart';

class SupabaseService {
  static bool _initialized = false;

  static SupabaseClient get client => Supabase.instance.client;

  static bool get isReady => _initialized && AppConfig.useSupabase;

  static Future<void> init() async {
    if (!AppConfig.useSupabase) {
      if (kDebugMode) {
        debugPrint('TickTock: Offline mod (Hive). ${AppConfig.configHint}');
      }
      return;
    }
    if (_initialized) return;

    final key = AppConfig.supabaseAnonKey;
    if (key.startsWith('sb_secret_')) {
      throw StateError(
        'SUPABASE_ANON_KEY olarak secret key kullanılamaz. Publishable key (sb_publishable_...) kullan.',
      );
    }

    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: key,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
    _initialized = true;

    if (kDebugMode) {
      debugPrint('TickTock: Supabase bağlandı → ${AppConfig.supabaseUrl}');
    }
  }

  static String? get currentUserId => client.auth.currentUser?.id;

  static bool get hasActiveSession => client.auth.currentSession != null;
}
