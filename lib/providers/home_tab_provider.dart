import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Alt navbar seçili sekme indeksi (0: Listeler, 1: Takvim, 2: Profil, 3: Ayarlar).
final homeTabIndexProvider = StateProvider<int>((ref) => 0);
