// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'TickTock';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get change => '更改';

  @override
  String get clear => '清除';

  @override
  String get navLists => '列表';

  @override
  String get navCalendar => '日历';

  @override
  String get navProfile => '个人资料';

  @override
  String get navSettings => '设置';

  @override
  String get listsTitle => '列表';

  @override
  String get noListsYet => '暂无列表';

  @override
  String get tapToCreateList => '点击 + 创建新列表';

  @override
  String get deleteList => '删除列表';

  @override
  String deleteListConfirm(String name) {
    return '删除「$name」？其中的所有任务将被移除。';
  }

  @override
  String get newList => '新建列表';

  @override
  String get listName => '列表名称';

  @override
  String get listNameHint => '例如：购物、工作';

  @override
  String get addTask => '添加任务';

  @override
  String get noDeadline => '无截止日期';

  @override
  String get setDeadline => '设置截止日期';

  @override
  String get noTasksYet => '此列表中暂无任务';

  @override
  String dueDate(String date) {
    return '截止：$date';
  }

  @override
  String get deleteTask => '删除任务';

  @override
  String get note => '备注';

  @override
  String get addNoteHint => '添加备注...';

  @override
  String get calendarTitle => '日历';

  @override
  String get eventsAndTasks => '事件与任务';

  @override
  String get noEventsOrTasks => '当天没有事件或任务';

  @override
  String get events => '事件';

  @override
  String get tasksDue => '待办任务';

  @override
  String get completed => '已完成';

  @override
  String get newEvent => '新建事件';

  @override
  String get editEvent => '编辑事件';

  @override
  String get title => '标题';

  @override
  String get start => '开始';

  @override
  String get end => '结束';

  @override
  String get color => '颜色';

  @override
  String get noteOptional => '备注（可选）';

  @override
  String get deleteEvent => '删除事件';

  @override
  String get deleteEventConfirm => '永久删除此事件？';

  @override
  String get theme => '主题';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get system => '系统';

  @override
  String get appearance => '外观';

  @override
  String get login => '登录';

  @override
  String get signUp => '注册';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get dontHaveAccount => '还没有账号？';

  @override
  String get alreadyHaveAccount => '已有账号？';

  @override
  String get logOut => '退出登录';

  @override
  String get invalidCredentials => '邮箱或密码错误';

  @override
  String get passwordMismatch => '两次密码不一致';

  @override
  String get emailRequired => '请输入邮箱';

  @override
  String get passwordRequired => '请输入密码';

  @override
  String get passwordTooShort => '密码至少6个字符';

  @override
  String get emailInvalid => '请输入有效的邮箱';

  @override
  String get nameRequired => '请输入姓名';

  @override
  String get createAccount => '创建账号';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get emailAlreadyInUse => '该邮箱已注册';

  @override
  String get profileTitle => '个人资料';

  @override
  String get editProfile => '编辑资料';

  @override
  String get noUserLoggedIn => '请登录以查看个人资料';

  @override
  String get settingsTitle => '设置';

  @override
  String get language => '语言';

  @override
  String get changeProfilePicture => '更换头像';

  @override
  String get changePassword => '修改密码';

  @override
  String get currentPassword => '当前密码';

  @override
  String get newPassword => '新密码';

  @override
  String get confirmNewPassword => '确认新密码';

  @override
  String get passwordChanged => '密码修改成功';

  @override
  String get wrongPassword => '当前密码不正确';

  @override
  String get account => '账号';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get removeProfilePicture => '移除头像';

  @override
  String get profilePictureUpdated => '头像已更新';

  @override
  String get profileUpdated => '资料已更新';

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
