// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get add => 'Ajouter';

  @override
  String get save => 'Enregistrer';

  @override
  String get change => 'Modifier';

  @override
  String get clear => 'Effacer';

  @override
  String get navLists => 'Listes';

  @override
  String get navCalendar => 'Calendrier';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get listsTitle => 'Listes';

  @override
  String get noListsYet => 'Aucune liste pour l\'instant';

  @override
  String get tapToCreateList => 'Appuyez sur + pour créer une nouvelle liste';

  @override
  String get deleteList => 'Supprimer la liste';

  @override
  String deleteListConfirm(String name) {
    return 'Supprimer « $name » ? Toutes les tâches seront supprimées.';
  }

  @override
  String get newList => 'Nouvelle liste';

  @override
  String get listName => 'Nom de la liste';

  @override
  String get listNameHint => 'ex. Courses, Travail';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get noDeadline => 'Pas de date limite';

  @override
  String get setDeadline => 'Définir la date';

  @override
  String get noTasksYet => 'Aucune tâche dans cette liste';

  @override
  String dueDate(String date) {
    return 'Échéance : $date';
  }

  @override
  String get deleteTask => 'Supprimer la tâche';

  @override
  String get note => 'Note';

  @override
  String get addNoteHint => 'Ajouter une note...';

  @override
  String get calendarTitle => 'Calendrier';

  @override
  String get eventsAndTasks => 'Événements et tâches';

  @override
  String get noEventsOrTasks => 'Aucun événement ni tâche pour ce jour';

  @override
  String get events => 'Événements';

  @override
  String get tasksDue => 'Tâches à échéance';

  @override
  String get completed => 'Terminée';

  @override
  String get newEvent => 'Nouvel événement';

  @override
  String get editEvent => 'Modifier l\'événement';

  @override
  String get title => 'Titre';

  @override
  String get start => 'Début';

  @override
  String get end => 'Fin';

  @override
  String get color => 'Couleur';

  @override
  String get noteOptional => 'Note (facultatif)';

  @override
  String get deleteEvent => 'Supprimer l\'événement';

  @override
  String get deleteEventConfirm => 'Supprimer définitivement cet événement ?';

  @override
  String get theme => 'Thème';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get appearance => 'Apparence';

  @override
  String get login => 'Se connecter';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get dontHaveAccount => 'Pas encore de compte ?';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ?';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get invalidCredentials => 'E-mail ou mot de passe incorrect';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get emailRequired => 'L\'e-mail est requis';

  @override
  String get passwordRequired => 'Le mot de passe est requis';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get emailInvalid => 'Veuillez entrer un e-mail valide';

  @override
  String get nameRequired => 'Le nom est requis';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get emailAlreadyInUse => 'Cet e-mail est déjà enregistré';

  @override
  String get profileTitle => 'Profil';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get noUserLoggedIn => 'Connectez-vous pour voir votre profil';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get changeProfilePicture => 'Changer la photo de profil';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmNewPassword => 'Confirmer le nouveau mot de passe';

  @override
  String get passwordChanged => 'Mot de passe modifié avec succès';

  @override
  String get wrongPassword => 'Le mot de passe actuel est incorrect';

  @override
  String get account => 'Compte';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get removeProfilePicture => 'Supprimer la photo de profil';

  @override
  String get profilePictureUpdated => 'Photo de profil mise à jour';

  @override
  String get profileUpdated => 'Profil mis à jour';

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
