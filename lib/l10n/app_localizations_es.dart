// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get add => 'Añadir';

  @override
  String get save => 'Guardar';

  @override
  String get change => 'Cambiar';

  @override
  String get clear => 'Borrar';

  @override
  String get navLists => 'Listas';

  @override
  String get navCalendar => 'Calendario';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get listsTitle => 'Listas';

  @override
  String get noListsYet => 'Aún no hay listas';

  @override
  String get tapToCreateList => 'Toca + para crear una nueva lista';

  @override
  String get deleteList => 'Eliminar lista';

  @override
  String deleteListConfirm(String name) {
    return '¿Eliminar \"$name\"? Se eliminarán todas las tareas.';
  }

  @override
  String get newList => 'Nueva lista';

  @override
  String get listName => 'Nombre de la lista';

  @override
  String get listNameHint => 'p. ej. Compras, Trabajo';

  @override
  String get addTask => 'Añadir tarea';

  @override
  String get noDeadline => 'Sin fecha límite';

  @override
  String get setDeadline => 'Establecer fecha';

  @override
  String get noTasksYet => 'Aún no hay tareas en esta lista';

  @override
  String dueDate(String date) {
    return 'Vence: $date';
  }

  @override
  String get deleteTask => 'Eliminar tarea';

  @override
  String get note => 'Nota';

  @override
  String get addNoteHint => 'Añadir una nota...';

  @override
  String get calendarTitle => 'Calendario';

  @override
  String get eventsAndTasks => 'Eventos y tareas';

  @override
  String get noEventsOrTasks => 'No hay eventos ni tareas para este día';

  @override
  String get events => 'Eventos';

  @override
  String get tasksDue => 'Tareas pendientes';

  @override
  String get completed => 'Completada';

  @override
  String get newEvent => 'Nuevo evento';

  @override
  String get editEvent => 'Editar evento';

  @override
  String get title => 'Título';

  @override
  String get start => 'Inicio';

  @override
  String get end => 'Fin';

  @override
  String get color => 'Color';

  @override
  String get noteOptional => 'Nota (opcional)';

  @override
  String get deleteEvent => 'Eliminar evento';

  @override
  String get deleteEventConfirm => '¿Eliminar este evento permanentemente?';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get appearance => 'Apariencia';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get dontHaveAccount => '¿No tienes cuenta?';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta?';

  @override
  String get logOut => 'Cerrar sesión';

  @override
  String get invalidCredentials => 'Correo o contraseña incorrectos';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden';

  @override
  String get emailRequired => 'El correo es obligatorio';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get emailInvalid => 'Introduce un correo válido';

  @override
  String get nameRequired => 'El nombre es obligatorio';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get emailAlreadyInUse => 'Este correo ya está registrado';

  @override
  String get emailConfirmationTitle => 'Confirma tu correo';

  @override
  String emailConfirmationMessage(String email) {
    return 'Enviamos un enlace de confirmación a $email. Ábrelo para activar tu cuenta.';
  }

  @override
  String get emailConfirmationInboxHint =>
      'Revisa tu bandeja de entrada y spam. El enlace abre esta app.';

  @override
  String get resendConfirmationEmail => 'Reenviar correo de confirmación';

  @override
  String get confirmationEmailResent => 'Correo de confirmación reenviado';

  @override
  String get emailNotConfirmed => 'Confirma tu correo antes de iniciar sesión';

  @override
  String get backToLogin => 'Volver al inicio de sesión';

  @override
  String get emailConfirmationResent =>
      'Este correo ya está registrado. Enviamos el enlace de confirmación de nuevo.';

  @override
  String get emailRateLimit =>
      'Límite de correos alcanzado (~4 por hora en Supabase gratuito). Espera una hora, revisa spam o configura SMTP personalizado.';

  @override
  String get emailConfirmed => 'Correo confirmado';

  @override
  String get emailNotConfirmedStatus => 'Correo no confirmado';

  @override
  String get emailConfirmedTooltip =>
      'Tu correo está verificado. profiles.email_confirmed_at está establecido en la base de datos.';

  @override
  String get emailNotConfirmedTooltip =>
      'Correo aún no verificado. Revisa profiles.email_confirmed_at en Supabase Table Editor.';

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
  String get profileTitle => 'Perfil';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get noUserLoggedIn => 'Inicia sesión para ver tu perfil';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get changeProfilePicture => 'Cambiar foto de perfil';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get currentPassword => 'Contraseña actual';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get confirmNewPassword => 'Confirmar nueva contraseña';

  @override
  String get passwordChanged => 'Contraseña cambiada correctamente';

  @override
  String get wrongPassword => 'La contraseña actual es incorrecta';

  @override
  String get account => 'Cuenta';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmTitle => '¿Eliminar cuenta?';

  @override
  String get deleteAccountConfirmMessage =>
      'Esto eliminará permanentemente tu cuenta y todos tus datos, incluidas listas, tareas y eventos del calendario. Esta acción no se puede deshacer.';

  @override
  String get accountDeleted => 'Tu cuenta ha sido eliminada';

  @override
  String get deleteAccountFailed =>
      'No se pudo eliminar la cuenta. Inténtalo de nuevo.';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get removeProfilePicture => 'Eliminar foto de perfil';

  @override
  String get profilePictureUpdated => 'Foto de perfil actualizada';

  @override
  String get profileUpdated => 'Perfil actualizado';

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
