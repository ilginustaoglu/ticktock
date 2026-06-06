import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static bool get useSupabase {
    final url = supabaseUrl;
    final key = supabaseAnonKey;
    if (url.isEmpty || key.isEmpty) return false;
    if (url.contains('YOUR_PROJECT_REF')) return false;
    if (key == 'your_anon_key_here' || key.contains('buraya_yapistir')) {
      return false;
    }
    // Secret key uygulamada kullanılmamalı
    if (key.startsWith('sb_secret_')) return false;
    return true;
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL']?.trim() ?? '';

  /// Supabase "Publishable key" (sb_publishable_...) veya legacy anon (eyJ...) key.
  static String get supabaseAnonKey =>
      (dotenv.env['SUPABASE_ANON_KEY'] ?? dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '')
          .trim();

  static String get configHint {
    if (useSupabase) return 'Supabase aktif: $supabaseUrl';
    final key = supabaseAnonKey;
    if (key.contains('buraya_yapistir') || key == 'your_anon_key_here') {
      return 'SUPABASE_ANON_KEY hâlâ placeholder — API Keys’ten publishable key yapıştır, sonra uygulamayı tamamen yeniden başlat (q → flutter run).';
    }
    if (key.isEmpty) return 'SUPABASE_ANON_KEY boş — .env dosyasını kontrol et.';
    if (key.startsWith('sb_secret_')) {
      return 'Secret key kullanılamaz — publishable key (sb_publishable_...) kullan.';
    }
    return 'Supabase yapılandırılamadı — SUPABASE_URL ve SUPABASE_ANON_KEY kontrol et.';
  }
}
