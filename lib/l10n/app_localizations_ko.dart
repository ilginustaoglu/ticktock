// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get add => '추가';

  @override
  String get save => '저장';

  @override
  String get change => '변경';

  @override
  String get clear => '지우기';

  @override
  String get navLists => '목록';

  @override
  String get navCalendar => '캘린더';

  @override
  String get navProfile => '프로필';

  @override
  String get navSettings => '설정';

  @override
  String get listsTitle => '목록';

  @override
  String get noListsYet => '목록이 없습니다';

  @override
  String get tapToCreateList => '+ 를 눌러 새 목록 만들기';

  @override
  String get deleteList => '목록 삭제';

  @override
  String deleteListConfirm(String name) {
    return '\"$name\"을(를) 삭제하시겠습니까? 모든 작업이 제거됩니다.';
  }

  @override
  String get newList => '새 목록';

  @override
  String get listName => '목록 이름';

  @override
  String get listNameHint => '예: 쇼핑, 업무';

  @override
  String get addTask => '작업 추가';

  @override
  String get noDeadline => '마감일 없음';

  @override
  String get setDeadline => '마감일 설정';

  @override
  String get noTasksYet => '이 목록에 작업이 없습니다';

  @override
  String dueDate(String date) {
    return '마감: $date';
  }

  @override
  String get deleteTask => '작업 삭제';

  @override
  String get note => '메모';

  @override
  String get addNoteHint => '메모 추가...';

  @override
  String get calendarTitle => '캘린더';

  @override
  String get eventsAndTasks => '일정 및 작업';

  @override
  String get noEventsOrTasks => '이 날짜에 일정이나 작업이 없습니다';

  @override
  String get events => '일정';

  @override
  String get tasksDue => '마감 작업';

  @override
  String get completed => '완료됨';

  @override
  String get newEvent => '새 일정';

  @override
  String get editEvent => '일정 편집';

  @override
  String get title => '제목';

  @override
  String get start => '시작';

  @override
  String get end => '종료';

  @override
  String get color => '색상';

  @override
  String get noteOptional => '메모 (선택)';

  @override
  String get deleteEvent => '일정 삭제';

  @override
  String get deleteEventConfirm => '이 일정을 영구적으로 삭제하시겠습니까?';

  @override
  String get theme => '테마';

  @override
  String get light => '라이트';

  @override
  String get dark => '다크';

  @override
  String get system => '시스템';

  @override
  String get appearance => '모양';

  @override
  String get login => '로그인';

  @override
  String get signUp => '회원가입';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get confirmPassword => '비밀번호 확인';

  @override
  String get firstName => '이름';

  @override
  String get lastName => '성';

  @override
  String get dontHaveAccount => '계정이 없으신가요?';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get logOut => '로그아웃';

  @override
  String get invalidCredentials => '이메일 또는 비밀번호가 올바르지 않습니다';

  @override
  String get passwordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String get emailRequired => '이메일을 입력하세요';

  @override
  String get passwordRequired => '비밀번호를 입력하세요';

  @override
  String get passwordTooShort => '비밀번호는 6자 이상이어야 합니다';

  @override
  String get emailInvalid => '유효한 이메일을 입력하세요';

  @override
  String get nameRequired => '이름을 입력하세요';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get welcomeBack => '다시 오신 것을 환영합니다';

  @override
  String get emailAlreadyInUse => '이미 등록된 이메일입니다';

  @override
  String get profileTitle => '프로필';

  @override
  String get editProfile => '프로필 편집';

  @override
  String get noUserLoggedIn => '프로필을 보려면 로그인하세요';

  @override
  String get settingsTitle => '설정';

  @override
  String get language => '언어';

  @override
  String get changeProfilePicture => '프로필 사진 변경';

  @override
  String get changePassword => '비밀번호 변경';

  @override
  String get currentPassword => '현재 비밀번호';

  @override
  String get newPassword => '새 비밀번호';

  @override
  String get confirmNewPassword => '새 비밀번호 확인';

  @override
  String get passwordChanged => '비밀번호가 변경되었습니다';

  @override
  String get wrongPassword => '현재 비밀번호가 올바르지 않습니다';

  @override
  String get account => '계정';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get removeProfilePicture => '프로필 사진 제거';

  @override
  String get profilePictureUpdated => '프로필 사진이 업데이트되었습니다';

  @override
  String get profileUpdated => '프로필이 업데이트되었습니다';

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
