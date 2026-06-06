// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get add => '追加';

  @override
  String get save => '保存';

  @override
  String get change => '変更';

  @override
  String get clear => 'クリア';

  @override
  String get navLists => 'リスト';

  @override
  String get navCalendar => 'カレンダー';

  @override
  String get navProfile => 'プロフィール';

  @override
  String get navSettings => '設定';

  @override
  String get listsTitle => 'リスト';

  @override
  String get noListsYet => 'リストがありません';

  @override
  String get tapToCreateList => '+ をタップして新しいリストを作成';

  @override
  String get deleteList => 'リストを削除';

  @override
  String deleteListConfirm(String name) {
    return '「$name」を削除しますか？中のタスクもすべて削除されます。';
  }

  @override
  String get newList => '新しいリスト';

  @override
  String get listName => 'リスト名';

  @override
  String get listNameHint => '例：買い物、仕事';

  @override
  String get addTask => 'タスクを追加';

  @override
  String get noDeadline => '期限なし';

  @override
  String get setDeadline => '期限を設定';

  @override
  String get noTasksYet => 'このリストにタスクはありません';

  @override
  String dueDate(String date) {
    return '期限：$date';
  }

  @override
  String get deleteTask => 'タスクを削除';

  @override
  String get note => 'メモ';

  @override
  String get addNoteHint => 'メモを追加...';

  @override
  String get calendarTitle => 'カレンダー';

  @override
  String get eventsAndTasks => 'イベントとタスク';

  @override
  String get noEventsOrTasks => 'この日のイベントやタスクはありません';

  @override
  String get events => 'イベント';

  @override
  String get tasksDue => '期限のタスク';

  @override
  String get completed => '完了';

  @override
  String get newEvent => '新しいイベント';

  @override
  String get editEvent => 'イベントを編集';

  @override
  String get title => 'タイトル';

  @override
  String get start => '開始';

  @override
  String get end => '終了';

  @override
  String get color => '色';

  @override
  String get noteOptional => 'メモ（任意）';

  @override
  String get deleteEvent => 'イベントを削除';

  @override
  String get deleteEventConfirm => 'このイベントを完全に削除しますか？';

  @override
  String get theme => 'テーマ';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get system => 'システム';

  @override
  String get appearance => '外観';

  @override
  String get login => 'ログイン';

  @override
  String get signUp => '新規登録';

  @override
  String get email => 'メール';

  @override
  String get password => 'パスワード';

  @override
  String get confirmPassword => 'パスワード確認';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get dontHaveAccount => 'アカウントをお持ちでないですか？';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？';

  @override
  String get logOut => 'ログアウト';

  @override
  String get invalidCredentials => 'メールまたはパスワードが正しくありません';

  @override
  String get passwordMismatch => 'パスワードが一致しません';

  @override
  String get emailRequired => 'メールは必須です';

  @override
  String get passwordRequired => 'パスワードは必須です';

  @override
  String get passwordTooShort => 'パスワードは6文字以上必要です';

  @override
  String get emailInvalid => '有効なメールを入力してください';

  @override
  String get nameRequired => '名前は必須です';

  @override
  String get createAccount => 'アカウント作成';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get emailAlreadyInUse => 'このメールは既に登録されています';

  @override
  String get emailConfirmationTitle => 'メールを確認してください';

  @override
  String emailConfirmationMessage(String email) {
    return '$email に確認リンクを送信しました。リンクを開いてアカウントを有効化してください。';
  }

  @override
  String get emailConfirmationInboxHint =>
      '受信トレイと迷惑メールを確認してください。リンクはこのアプリを開きます。';

  @override
  String get resendConfirmationEmail => '確認メールを再送信';

  @override
  String get confirmationEmailResent => '確認メールを再送信しました';

  @override
  String get emailNotConfirmed => 'ログインする前にメールを確認してください';

  @override
  String get backToLogin => 'ログインに戻る';

  @override
  String get emailConfirmationResent => 'このメールは既に登録されています。確認リンクを再送信しました。';

  @override
  String get emailRateLimit =>
      'メール送信上限に達しました（無料Supabaseは約4通/時）。1時間ほど待つか、迷惑メールを確認するか、カスタムSMTPを設定してください。';

  @override
  String get emailConfirmed => 'メール確認済み';

  @override
  String get emailNotConfirmedStatus => 'メール未確認';

  @override
  String get emailConfirmedTooltip =>
      'メールは確認済みです。データベースの profiles.email_confirmed_at が設定されています。';

  @override
  String get emailNotConfirmedTooltip =>
      'メールはまだ確認されていません。Supabase Table Editor の profiles.email_confirmed_at を確認してください。';

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
  String get profileTitle => 'プロフィール';

  @override
  String get editProfile => 'プロフィールを編集';

  @override
  String get noUserLoggedIn => 'プロフィールを見るにはログインしてください';

  @override
  String get settingsTitle => '設定';

  @override
  String get language => '言語';

  @override
  String get changeProfilePicture => 'プロフィール写真を変更';

  @override
  String get changePassword => 'パスワードを変更';

  @override
  String get currentPassword => '現在のパスワード';

  @override
  String get newPassword => '新しいパスワード';

  @override
  String get confirmNewPassword => '新しいパスワードを確認';

  @override
  String get passwordChanged => 'パスワードを変更しました';

  @override
  String get wrongPassword => '現在のパスワードが正しくありません';

  @override
  String get account => 'アカウント';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get removeProfilePicture => 'プロフィール写真を削除';

  @override
  String get profilePictureUpdated => 'プロフィール写真を更新しました';

  @override
  String get profileUpdated => 'プロフィールを更新しました';

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
