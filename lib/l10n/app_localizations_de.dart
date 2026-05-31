// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get save => 'Speichern';

  @override
  String get change => 'Ändern';

  @override
  String get clear => 'Löschen';

  @override
  String get navLists => 'Listen';

  @override
  String get navCalendar => 'Kalender';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get listsTitle => 'Listen';

  @override
  String get noListsYet => 'Noch keine Listen';

  @override
  String get tapToCreateList => 'Tippe auf +, um eine neue Liste zu erstellen';

  @override
  String get deleteList => 'Liste löschen';

  @override
  String deleteListConfirm(String name) {
    return '\"$name\" löschen? Alle Aufgaben darin werden entfernt.';
  }

  @override
  String get newList => 'Neue Liste';

  @override
  String get listName => 'Listenname';

  @override
  String get listNameHint => 'z. B. Einkauf, Arbeit';

  @override
  String get addTask => 'Aufgabe hinzufügen';

  @override
  String get noDeadline => 'Keine Frist';

  @override
  String get setDeadline => 'Frist setzen';

  @override
  String get noTasksYet => 'Noch keine Aufgaben in dieser Liste';

  @override
  String dueDate(String date) {
    return 'Fällig: $date';
  }

  @override
  String get deleteTask => 'Aufgabe löschen';

  @override
  String get note => 'Notiz';

  @override
  String get addNoteHint => 'Notiz hinzufügen...';

  @override
  String get calendarTitle => 'Kalender';

  @override
  String get eventsAndTasks => 'Termine & Aufgaben';

  @override
  String get noEventsOrTasks => 'Keine Termine oder Aufgaben an diesem Tag';

  @override
  String get events => 'Termine';

  @override
  String get tasksDue => 'Fällige Aufgaben';

  @override
  String get completed => 'Erledigt';

  @override
  String get newEvent => 'Neuer Termin';

  @override
  String get editEvent => 'Termin bearbeiten';

  @override
  String get title => 'Titel';

  @override
  String get start => 'Beginn';

  @override
  String get end => 'Ende';

  @override
  String get color => 'Farbe';

  @override
  String get noteOptional => 'Notiz (optional)';

  @override
  String get deleteEvent => 'Termin löschen';

  @override
  String get deleteEventConfirm => 'Diesen Termin dauerhaft löschen?';

  @override
  String get theme => 'Design';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get system => 'System';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get login => 'Anmelden';

  @override
  String get signUp => 'Registrieren';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get firstName => 'Vorname';

  @override
  String get lastName => 'Nachname';

  @override
  String get dontHaveAccount => 'Noch kein Konto?';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto?';

  @override
  String get logOut => 'Abmelden';

  @override
  String get invalidCredentials => 'Ungültige E-Mail oder Passwort';

  @override
  String get passwordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get emailRequired => 'E-Mail ist erforderlich';

  @override
  String get passwordRequired => 'Passwort ist erforderlich';

  @override
  String get passwordTooShort => 'Passwort muss mindestens 6 Zeichen haben';

  @override
  String get emailInvalid => 'Bitte gültige E-Mail eingeben';

  @override
  String get nameRequired => 'Name ist erforderlich';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get emailAlreadyInUse => 'Diese E-Mail ist bereits registriert';

  @override
  String get profileTitle => 'Profil';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get noUserLoggedIn =>
      'Bitte melden Sie sich an, um Ihr Profil zu sehen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get changeProfilePicture => 'Profilbild ändern';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get currentPassword => 'Aktuelles Passwort';

  @override
  String get newPassword => 'Neues Passwort';

  @override
  String get confirmNewPassword => 'Neues Passwort bestätigen';

  @override
  String get passwordChanged => 'Passwort erfolgreich geändert';

  @override
  String get wrongPassword => 'Aktuelles Passwort ist falsch';

  @override
  String get account => 'Konto';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get removeProfilePicture => 'Profilbild entfernen';

  @override
  String get profilePictureUpdated => 'Profilbild aktualisiert';

  @override
  String get profileUpdated => 'Profil aktualisiert';

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
