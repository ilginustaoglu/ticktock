# Widget test rehberi

## 1. Flutter widget testleri (CI / bilgisayar)

Uygulama içi ekranlar ve widget’lar için `flutter test` kullanılır.

### Çalıştırma

```bash
cd /Users/ilgin/projects/ticktock
flutter test
```

Tek dosya:

```bash
flutter test test/widget_test.dart
```

### Ne test ediliyor?

- **TickTockApp**: Açılış, splash sonrası “Tasks” ekranı ve boş liste mesajı.
- **ThemeModeButton**: Tıklanınca Light / Dark / System menüsü çıkıyor mu.

### Yeni widget testi eklemek

1. `test/` altında yeni dosya (örn. `test/calendar_screen_test.dart`).
2. `testWidgets('açıklama', (WidgetTester tester) async { ... });` kullan.
3. `pumpWidget` ile widget’ı ver, `find` ile eleman bul, `expect` ile kontrol et.

Örnek:

```dart
testWidgets('Calendar shows title', (tester) async {
  await tester.pumpWidget(
    const ProviderScope(child: MaterialApp(home: CalendarScreen())),
  );
  expect(find.text('Calendar'), findsOneWidget);
});
```

Riverpod kullanan ekranlar için mutlaka `ProviderScope` (ve gerekirse ilgili provider’lar) sarmalayın.

---

## 2. Home screen widget’ı test etmek (Android)

Ana ekrandaki “TickTock” kutusu (liste özeti) **gerçek cihaz/emülatör** üzerinde test edilir.

### Ön koşul

- `home_widget` şu an kapalı (iOS build için). Sadece **Android**’de widget kullanacaksan:

1. **pubspec.yaml** içinde yorumu kaldır:

   ```yaml
   dependencies:
     home_widget: ^0.9.0
   ```

2. `flutter pub get`
3. **HomeWidgetHelper** içinde gerçek implementasyonu yaz (şu an no-op):  
   `HomeWidget.saveWidgetData` ve `HomeWidget.updateWidget(name: 'TickTockWidgetProvider')` çağrıları.

### Android tarafında widget’ı eklemek

1. Android Studio ile `android/` aç.
2. **File → New → Widget → App Widget** ile yeni widget oluştur.
3. `HomeWidgetProvider` kullan (paket dokümantasyonuna göre).
4. Provider adı: **`TickTockWidgetProvider`** (HomeWidgetHelper’daki ile aynı).
5. Layout’ta gösterilecek key’ler:  
   `list_titles`, `total_uncompleted`, `first_list_preview` (HomeWidgetHelper’da tanımlı).

### Test adımları

1. Uygulamayı Android cihaz/emülatörde çalıştır:  
   `flutter run -d <android_device_id>`
2. Uygulama içinde en az bir liste ve birkaç görev ekle (tamamlanmamış olsun).
3. Ana ekrana git → widget ekle → “TickTock” veya verdiğin widget adını seç.
4. Widget’ta liste adları, tamamlanmamış sayı veya önizleme metni görünüyor mu kontrol et.
5. Uygulamada liste/görev ekleyip veya tamamlayıp widget’ın güncellenmesini bekle; tekrar kontrol et.

### Özet

| Ne test ediyorsun?        | Nasıl?                                      |
|---------------------------|---------------------------------------------|
| Flutter UI / ekranlar     | `flutter test` + `test/widget_test.dart`    |
| Ana ekran widget’ı       | Android’de widget ekleyip manuel kontrol   |
