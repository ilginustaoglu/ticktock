// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get add => 'Ekle';

  @override
  String get save => 'Kaydet';

  @override
  String get change => 'Değiştir';

  @override
  String get clear => 'Temizle';

  @override
  String get navLists => 'Listeler';

  @override
  String get navCalendar => 'Takvim';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get listsTitle => 'Listeler';

  @override
  String get noListsYet => 'Henüz liste yok';

  @override
  String get tapToCreateList =>
      'Yeni liste oluşturmak için + simgesine dokunun';

  @override
  String get deleteList => 'Listeyi sil';

  @override
  String deleteListConfirm(String name) {
    return '\"$name\" silinsin mi? İçindeki tüm görevler kaldırılacak.';
  }

  @override
  String get newList => 'Yeni liste';

  @override
  String get listName => 'Liste adı';

  @override
  String get listNameHint => 'ör. Alışveriş, İş';

  @override
  String get addTask => 'Görev ekle';

  @override
  String get noDeadline => 'Son tarih yok';

  @override
  String get setDeadline => 'Son tarih belirle';

  @override
  String get noTasksYet => 'Bu listede henüz görev yok';

  @override
  String dueDate(String date) {
    return 'Son tarih: $date';
  }

  @override
  String get deleteTask => 'Görevi sil';

  @override
  String get note => 'Not';

  @override
  String get addNoteHint => 'Not ekle...';

  @override
  String get calendarTitle => 'Takvim';

  @override
  String get eventsAndTasks => 'Etkinlikler ve görevler';

  @override
  String get noEventsOrTasks => 'Bu gün için etkinlik veya görev yok';

  @override
  String get events => 'Etkinlikler';

  @override
  String get tasksDue => 'Son tarihi gelen görevler';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get newEvent => 'Yeni etkinlik';

  @override
  String get editEvent => 'Etkinliği düzenle';

  @override
  String get title => 'Başlık';

  @override
  String get start => 'Başlangıç';

  @override
  String get end => 'Bitiş';

  @override
  String get color => 'Renk';

  @override
  String get noteOptional => 'Not (isteğe bağlı)';

  @override
  String get deleteEvent => 'Etkinliği sil';

  @override
  String get deleteEventConfirm => 'Bu etkinlik kalıcı olarak silinsin mi?';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get system => 'Sistem';

  @override
  String get appearance => 'Görünüm';

  @override
  String get login => 'Giriş yap';

  @override
  String get signUp => 'Kayıt ol';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get confirmPassword => 'Şifreyi onayla';

  @override
  String get firstName => 'Ad';

  @override
  String get lastName => 'Soyad';

  @override
  String get dontHaveAccount => 'Hesabınız yok mu?';

  @override
  String get alreadyHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get logOut => 'Çıkış yap';

  @override
  String get invalidCredentials => 'Geçersiz e-posta veya şifre';

  @override
  String get passwordMismatch => 'Şifreler eşleşmiyor';

  @override
  String get emailRequired => 'E-posta gerekli';

  @override
  String get passwordRequired => 'Şifre gerekli';

  @override
  String get passwordTooShort => 'Şifre en az 6 karakter olmalı';

  @override
  String get emailInvalid => 'Geçerli bir e-posta girin';

  @override
  String get nameRequired => 'Ad gerekli';

  @override
  String get createAccount => 'Hesap oluştur';

  @override
  String get welcomeBack => 'Tekrar hoş geldiniz';

  @override
  String get emailAlreadyInUse => 'Bu e-posta zaten kayıtlı';

  @override
  String get profileTitle => 'Profil';

  @override
  String get editProfile => 'Profili düzenle';

  @override
  String get noUserLoggedIn => 'Profilinizi görmek için giriş yapın';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get language => 'Dil';

  @override
  String get changeProfilePicture => 'Profil resmini değiştir';

  @override
  String get changePassword => 'Şifreyi değiştir';

  @override
  String get currentPassword => 'Mevcut şifre';

  @override
  String get newPassword => 'Yeni şifre';

  @override
  String get confirmNewPassword => 'Yeni şifreyi onayla';

  @override
  String get passwordChanged => 'Şifre başarıyla değiştirildi';

  @override
  String get wrongPassword => 'Mevcut şifre yanlış';

  @override
  String get account => 'Hesap';

  @override
  String get selectLanguage => 'Dil seçin';

  @override
  String get removeProfilePicture => 'Profil resmini kaldır';

  @override
  String get profilePictureUpdated => 'Profil resmi güncellendi';

  @override
  String get profileUpdated => 'Profil güncellendi';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChinese => '中文';

  @override
  String get languageKorean => '한국어';
}
