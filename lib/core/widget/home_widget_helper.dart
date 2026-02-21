/// Home screen widget'a gönderilecek veri. Native tarafta bu key'lerle okunur.
/// Widget kullanmak için pubspec'e home_widget ekleyip bu sınıfı gerçek
/// implementasyonla değiştirin (şu an no-op; iOS build için home_widget kaldırıldı).
class HomeWidgetHelper {
  static const String providerName = 'TickTockWidgetProvider';

  static const String keyListTitles = 'list_titles';
  static const String keyTotalUncompleted = 'total_uncompleted';
  static const String keyFirstListPreview = 'first_list_preview';

  /// Güncel todo verisini widget'a yazar ve widget'ı yeniler.
  /// home_widget bağımlılığı yokken no-op.
  static Future<void> updateWidgetData() async {
    // Widget kapalıyken no-op (home_widget kaldırıldığı için iOS build alınsın diye).
    // Widget açmak için pubspec'e home_widget ekleyip bu metodu gerçek implementasyonla değiştirin.
  }
}
