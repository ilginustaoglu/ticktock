# TickTock

Todo + takvim uygulaması. Listeler, tamamlanan/tamamlanmayan görevler, notlar ve haftalık/aylık takvim. Home screen widget desteği (veri Flutter tarafında hazır; Android widget UI için native kurulum gerekir).

## Yapı

- **Listeler**: Birden fazla todo listesi, her listede görevler (completed/uncompleted), görevlere not.
- **Takvim**: `table_calendar` ile haftalık/aylık görünüm, etkinlik ekleme.
- **Tema**: Sade, Microsoft To Do / Google Calendar tarzı (AppTheme).
- **Depolama**: Hive (yerel).
- **State**: Riverpod (todoListsProvider, todoItemsProvider, calendarEventsProvider).

## Home Widget (opsiyonel)

Şu an **home_widget** bağımlılığı kapalı (iOS’ta modül çakışması nedeniyle). Uygulama iOS’ta sorunsuz derlenir; widget çağrıları no-op. Sadece **Android** için widget kullanacaksanız: `pubspec.yaml` içindeki `home_widget: ^0.9.0` yorumunu kaldırıp `flutter pub get` yapın, `lib/core/widget/home_widget_helper.dart` içinde `HomeWidget.saveWidgetData` / `HomeWidget.updateWidget` ile gerçek implementasyonu yazın. Provider adı: `TickTockWidgetProvider`. Key’ler: `list_titles`, `total_uncompleted`, `first_list_preview`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
