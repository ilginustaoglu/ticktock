// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get change => 'Change';

  @override
  String get clear => 'Clear';

  @override
  String get navLists => 'Lists';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get listsTitle => 'Lists';

  @override
  String get noListsYet => 'No lists yet';

  @override
  String get tapToCreateList => 'Tap + to create a new list';

  @override
  String get deleteList => 'Delete list';

  @override
  String deleteListConfirm(String name) {
    return 'Delete \"$name\"? All tasks in it will be removed.';
  }

  @override
  String get newList => 'New list';

  @override
  String get listName => 'List name';

  @override
  String get listNameHint => 'e.g. Shopping, Work';

  @override
  String get addTask => 'Add a task';

  @override
  String get noDeadline => 'No deadline';

  @override
  String get setDeadline => 'Set deadline';

  @override
  String get noTasksYet => 'No tasks in this list yet';

  @override
  String dueDate(String date) {
    return 'Due: $date';
  }

  @override
  String get deleteTask => 'Delete task';

  @override
  String get note => 'Note';

  @override
  String get addNoteHint => 'Add a note...';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get eventsAndTasks => 'Events & tasks';

  @override
  String get noEventsOrTasks => 'No events or tasks due on this day';

  @override
  String get events => 'Events';

  @override
  String get tasksDue => 'Tasks due';

  @override
  String get completed => 'Completed';

  @override
  String get newEvent => 'New event';

  @override
  String get editEvent => 'Edit event';

  @override
  String get title => 'Title';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get color => 'Color';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get deleteEvent => 'Delete event';

  @override
  String get deleteEventConfirm => 'Permanently delete this event?';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get appearance => 'Appearance';

  @override
  String get login => 'Log in';

  @override
  String get signUp => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logOut => 'Log out';

  @override
  String get invalidCredentials => 'Invalid email or password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get createAccount => 'Create account';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get emailAlreadyInUse => 'This email is already registered';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get noUserLoggedIn => 'Please log in to view your profile';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get changeProfilePicture => 'Change profile picture';

  @override
  String get changePassword => 'Change password';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get passwordChanged => 'Password changed successfully';

  @override
  String get wrongPassword => 'Current password is incorrect';

  @override
  String get account => 'Account';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get removeProfilePicture => 'Remove profile picture';

  @override
  String get profilePictureUpdated => 'Profile picture updated';

  @override
  String get profileUpdated => 'Profile updated';

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
