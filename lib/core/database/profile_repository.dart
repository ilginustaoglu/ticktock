import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../models/user.dart';
import '../database/supabase_service.dart';

class ProfileRepository {
  static Future<User?> fetchById(String userId) async {
    final row = await SupabaseService.client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
    if (row == null) return null;

    final authUser = SupabaseService.client.auth.currentUser;
    final authConfirmedAt = authUser?.emailConfirmedAt;
    return User.fromSupabase(
      profile: Map<String, dynamic>.from(row),
      email: authUser?.email ?? (row['email'] as String? ?? ''),
      emailConfirmedAt: authConfirmedAt != null
          ? DateTime.tryParse(authConfirmedAt)
          : null,
    );
  }

  /// Auth oturumu var ama profiles satırı yoksa oluşturur (trigger kaçmış olabilir).
  static Future<User?> ensureForAuthUser(sb.User authUser) async {
    final existing = await fetchById(authUser.id);
    if (existing != null) return existing;

    final meta = authUser.userMetadata ?? {};
    final confirmedAt = authUser.emailConfirmedAt;

    await SupabaseService.client.from('profiles').upsert({
      'id': authUser.id,
      'email': authUser.email,
      'first_name': meta['first_name'] as String? ?? '',
      'last_name': meta['last_name'] as String? ?? '',
      if (confirmedAt != null) 'email_confirmed_at': confirmedAt,
    });

    return fetchById(authUser.id);
  }

  static Future<void> update({
    required String userId,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    bool clearProfileImage = false,
    String? themeMode,
    String? locale,
  }) async {
    final updates = <String, dynamic>{};
    if (firstName != null) updates['first_name'] = firstName;
    if (lastName != null) updates['last_name'] = lastName;
    if (clearProfileImage) {
      updates['profile_image_url'] = null;
    } else if (profileImageUrl != null) {
      updates['profile_image_url'] = profileImageUrl;
    }
    if (themeMode != null) updates['theme_mode'] = themeMode;
    if (locale != null) updates['locale'] = locale;
    if (updates.isEmpty) return;

    await SupabaseService.client.from('profiles').update(updates).eq('id', userId);
  }

  static Future<String?> fetchThemeMode(String userId) async {
    final row = await SupabaseService.client
        .from('profiles')
        .select('theme_mode')
        .eq('id', userId)
        .maybeSingle();
    return row?['theme_mode'] as String?;
  }

  static Future<String?> fetchLocale(String userId) async {
    final row = await SupabaseService.client
        .from('profiles')
        .select('locale')
        .eq('id', userId)
        .maybeSingle();
    return row?['locale'] as String?;
  }
}
