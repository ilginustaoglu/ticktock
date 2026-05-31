// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get add => 'Aggiungi';

  @override
  String get save => 'Salva';

  @override
  String get change => 'Modifica';

  @override
  String get clear => 'Cancella';

  @override
  String get navLists => 'Liste';

  @override
  String get navCalendar => 'Calendario';

  @override
  String get navProfile => 'Profilo';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get listsTitle => 'Liste';

  @override
  String get noListsYet => 'Nessuna lista ancora';

  @override
  String get tapToCreateList => 'Tocca + per creare una nuova lista';

  @override
  String get deleteList => 'Elimina lista';

  @override
  String deleteListConfirm(String name) {
    return 'Eliminare \"$name\"? Tutte le attività verranno rimosse.';
  }

  @override
  String get newList => 'Nuova lista';

  @override
  String get listName => 'Nome lista';

  @override
  String get listNameHint => 'es. Spesa, Lavoro';

  @override
  String get addTask => 'Aggiungi attività';

  @override
  String get noDeadline => 'Nessuna scadenza';

  @override
  String get setDeadline => 'Imposta scadenza';

  @override
  String get noTasksYet => 'Nessuna attività in questa lista';

  @override
  String dueDate(String date) {
    return 'Scadenza: $date';
  }

  @override
  String get deleteTask => 'Elimina attività';

  @override
  String get note => 'Nota';

  @override
  String get addNoteHint => 'Aggiungi una nota...';

  @override
  String get calendarTitle => 'Calendario';

  @override
  String get eventsAndTasks => 'Eventi e attività';

  @override
  String get noEventsOrTasks => 'Nessun evento o attività per questo giorno';

  @override
  String get events => 'Eventi';

  @override
  String get tasksDue => 'Attività in scadenza';

  @override
  String get completed => 'Completata';

  @override
  String get newEvent => 'Nuovo evento';

  @override
  String get editEvent => 'Modifica evento';

  @override
  String get title => 'Titolo';

  @override
  String get start => 'Inizio';

  @override
  String get end => 'Fine';

  @override
  String get color => 'Colore';

  @override
  String get noteOptional => 'Nota (facoltativo)';

  @override
  String get deleteEvent => 'Elimina evento';

  @override
  String get deleteEventConfirm => 'Eliminare definitivamente questo evento?';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get system => 'Sistema';

  @override
  String get appearance => 'Aspetto';

  @override
  String get login => 'Accedi';

  @override
  String get signUp => 'Registrati';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get firstName => 'Nome';

  @override
  String get lastName => 'Cognome';

  @override
  String get dontHaveAccount => 'Non hai un account?';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get logOut => 'Esci';

  @override
  String get invalidCredentials => 'E-mail o password non validi';

  @override
  String get passwordMismatch => 'Le password non corrispondono';

  @override
  String get emailRequired => 'L\'e-mail è obbligatoria';

  @override
  String get passwordRequired => 'La password è obbligatoria';

  @override
  String get passwordTooShort =>
      'La password deve contenere almeno 6 caratteri';

  @override
  String get emailInvalid => 'Inserisci un\'e-mail valida';

  @override
  String get nameRequired => 'Il nome è obbligatorio';

  @override
  String get createAccount => 'Crea account';

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get emailAlreadyInUse => 'Questa e-mail è già registrata';

  @override
  String get profileTitle => 'Profilo';

  @override
  String get editProfile => 'Modifica profilo';

  @override
  String get noUserLoggedIn => 'Accedi per vedere il tuo profilo';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get language => 'Lingua';

  @override
  String get changeProfilePicture => 'Cambia foto profilo';

  @override
  String get changePassword => 'Cambia password';

  @override
  String get currentPassword => 'Password attuale';

  @override
  String get newPassword => 'Nuova password';

  @override
  String get confirmNewPassword => 'Conferma nuova password';

  @override
  String get passwordChanged => 'Password modificata con successo';

  @override
  String get wrongPassword => 'La password attuale non è corretta';

  @override
  String get account => 'Account';

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get removeProfilePicture => 'Rimuovi foto profilo';

  @override
  String get profilePictureUpdated => 'Foto profilo aggiornata';

  @override
  String get profileUpdated => 'Profilo aggiornato';

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
