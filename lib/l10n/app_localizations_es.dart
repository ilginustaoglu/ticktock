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
