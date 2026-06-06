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
  String get emailConfirmationTitle => 'Confirmez votre e-mail';

  @override
  String emailConfirmationMessage(String email) {
    return 'Nous avons envoyé un lien de confirmation à $email. Ouvrez-le pour activer votre compte.';
  }

  @override
  String get emailConfirmationInboxHint =>
      'Vérifiez votre boîte de réception et les spams. Le lien ouvre cette application.';

  @override
  String get resendConfirmationEmail => 'Renvoyer l\'e-mail de confirmation';

  @override
  String get confirmationEmailResent => 'E-mail de confirmation renvoyé';

  @override
  String get emailNotConfirmed =>
      'Veuillez confirmer votre e-mail avant de vous connecter';

  @override
  String get backToLogin => 'Retour à la connexion';

  @override
  String get emailConfirmationResent =>
      'Cet e-mail est déjà enregistré. Nous avons renvoyé le lien de confirmation.';

  @override
  String get emailRateLimit =>
      'Limite d\'envoi atteinte (~4 par heure sur Supabase gratuit). Attendez une heure, vérifiez les spams ou configurez un SMTP personnalisé.';

  @override
  String get emailConfirmed => 'E-mail confirmé';

  @override
  String get emailNotConfirmedStatus => 'E-mail non confirmé';

  @override
  String get emailConfirmedTooltip =>
      'Votre e-mail est vérifié. profiles.email_confirmed_at est défini dans la base de données.';

  @override
  String get emailNotConfirmedTooltip =>
      'E-mail pas encore vérifié. Vérifiez profiles.email_confirmed_at dans Supabase Table Editor.';

  @override
  String get loginFailedHelp =>
      'Sign-in failed. Common causes: email not confirmed yet (Confirm user in Supabase), wrong password, or account was created only on this device before Supabase was connected.';

  @override
  String get localAccountLogin =>
      'Signed in with your on-device account. Data is not in the cloud yet — sign up in the app with the same email to sync with Supabase.';

  @override
  String get profileMissing =>
      'Account exists but profile could not be loaded. Run database/migrations/001_profiles_email_confirmed.sql in Supabase.';

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
