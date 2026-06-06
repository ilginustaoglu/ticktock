import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:uuid/uuid.dart';

import '../core/config/app_config.dart';
import '../core/config/auth_config.dart';
import '../core/database/profile_repository.dart';
import '../core/database/supabase_service.dart';
import '../core/storage/user_storage.dart';
import '../core/utils/password_utils.dart';
import '../models/user.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final String? errorMessage;
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier()..init();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(status: AuthStatus.loading));

  Future<void> init() async {
    await _restoreSession();
  }

  Future<void> _restoreSession() async {
    if (SupabaseService.isReady) {
      final session = SupabaseService.client.auth.currentSession;
      if (session != null) {
        try {
          var user = await ProfileRepository.fetchById(session.user.id);
          user ??= await ProfileRepository.ensureForAuthUser(session.user);
          if (user == null) {
            state = const AuthState(status: AuthStatus.unauthenticated);
            return;
          }
          state = AuthState(status: AuthStatus.authenticated, user: user);
        } catch (e) {
          if (kDebugMode) debugPrint('TickTock restoreSession: $e');
          state = const AuthState(status: AuthStatus.unauthenticated);
        }
        return;
      }
    }

    final userId = UserStorage.getCurrentUserId();
    if (userId == null) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }
    final users = UserStorage.getUsers();
    final user = users.cast<User?>().firstWhere(
          (u) => u?.id == userId,
          orElse: () => null,
        );
    if (user == null) {
      await UserStorage.setCurrentUserId(null);
      state = const AuthState(status: AuthStatus.unauthenticated);
    } else {
      state = AuthState(status: AuthStatus.authenticated, user: user);
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return 'emailRequired';
    if (!isValidEmail(normalizedEmail)) return 'emailInvalid';
    if (password.isEmpty) return 'passwordRequired';
    if (password.length < 6) return 'passwordTooShort';
    if (password != confirmPassword) return 'passwordMismatch';
    if (firstName.trim().isEmpty) return 'nameRequired';

    if (SupabaseService.isReady) {
      try {
        final response = await SupabaseService.client.auth.signUp(
          email: normalizedEmail,
          password: password,
          emailRedirectTo: authRedirectUrl,
          data: {
            'first_name': firstName.trim(),
            'last_name': lastName.trim(),
          },
        );
        final authUser = response.user;
        if (authUser == null) return 'invalidCredentials';

        final identities = authUser.identities;
        if (identities != null && identities.isEmpty) {
          final resendError = await _resendConfirmationOrError(normalizedEmail);
          if (resendError != null) return resendError;
          return 'emailConfirmationResent';
        }

        if (response.session == null) {
          return 'emailConfirmationRequired';
        }
        final user = await ProfileRepository.fetchById(authUser.id);
        state = AuthState(status: AuthStatus.authenticated, user: user);
        return null;
      } on AuthException catch (e) {
        if (kDebugMode) debugPrint('TickTock signUp: $e');
        return _mapAuthException(e);
      }
    }

    final users = UserStorage.getUsers();
    if (users.any((u) => u.email == normalizedEmail)) {
      return 'emailAlreadyInUse';
    }

    final user = User(
      id: const Uuid().v4(),
      email: normalizedEmail,
      passwordHash: hashPassword(password, normalizedEmail),
      firstName: firstName.trim(),
      lastName: lastName.trim(),
    );
    users.add(user);
    await UserStorage.saveUsers(users);
    await UserStorage.setCurrentUserId(user.id);
    state = AuthState(status: AuthStatus.authenticated, user: user);
    return null;
  }

  Future<String?> logIn({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return 'emailRequired';
    if (password.isEmpty) return 'passwordRequired';

    if (SupabaseService.isReady) {
      try {
        final response = await SupabaseService.client.auth.signInWithPassword(
          email: normalizedEmail,
          password: password,
        );
        final authUser = response.user;
        if (authUser == null) return 'invalidCredentials';
        var user = await ProfileRepository.fetchById(authUser.id);
        user ??= await ProfileRepository.ensureForAuthUser(authUser);
        if (user == null) return 'profileMissing';
        state = AuthState(status: AuthStatus.authenticated, user: user);
        return null;
      } on AuthException catch (e) {
        if (kDebugMode) debugPrint('TickTock logIn: $e');
        if (_isEmailNotConfirmed(e)) return 'emailNotConfirmed';
        if (e.code == 'invalid_credentials') {
          final localResult = await _tryLocalLogin(normalizedEmail, password);
          if (localResult != null) return localResult;
          return 'loginFailedHelp';
        }
        return _mapAuthException(e);
      } catch (e) {
        if (kDebugMode) debugPrint('TickTock logIn unexpected: $e');
        return 'loginFailedHelp';
      }
    }

    return _tryLocalLogin(normalizedEmail, password);
  }

  Future<String?> _tryLocalLogin(String normalizedEmail, String password) async {
    final users = UserStorage.getUsers();
    final user = users.cast<User?>().firstWhere(
          (u) => u?.email == normalizedEmail,
          orElse: () => null,
        );
    if (user == null ||
        user.passwordHash != hashPassword(password, normalizedEmail)) {
      return 'invalidCredentials';
    }

    await UserStorage.setCurrentUserId(user.id);
    state = AuthState(status: AuthStatus.authenticated, user: user);
    if (SupabaseService.isReady) return 'localAccountLogin';
    return null;
  }

  Future<String?> resendConfirmationEmail(String email) async {
    if (!SupabaseService.isReady) return 'invalidCredentials';
    return _resendConfirmationOrError(email.trim().toLowerCase());
  }

  Future<String?> _resendConfirmationOrError(String normalizedEmail) async {
    try {
      await SupabaseService.client.auth.resend(
        type: OtpType.signup,
        email: normalizedEmail,
        emailRedirectTo: authRedirectUrl,
      );
      return null;
    } on AuthException catch (e) {
      if (kDebugMode) debugPrint('TickTock resend: $e');
      return _mapAuthException(e);
    }
  }

  Future<void> refreshFromSession() async {
    await _restoreSession();
  }

  bool _isEmailNotConfirmed(AuthException e) {
    final msg = e.message.toLowerCase();
    return msg.contains('email not confirmed') ||
        msg.contains('not confirmed') ||
        e.code == 'email_not_confirmed';
  }

  String _mapAuthException(AuthException e) {
    if (_isRateLimitError(e)) return 'emailRateLimit';
    final msg = e.message.toLowerCase();
    if (msg.contains('already registered') || msg.contains('already been registered')) {
      return 'emailAlreadyInUse';
    }
    if (msg.contains('password') && msg.contains('weak')) return 'passwordTooShort';
    return 'invalidCredentials';
  }

  bool _isRateLimitError(AuthException e) {
    if (e.code == 'over_email_send_rate_limit' || e.code == '429') return true;
    if (e.statusCode == '429') return true;
    final msg = e.message.toLowerCase();
    return msg.contains('rate limit') || msg.contains('email rate limit');
  }

  Future<void> logOut() async {
    if (SupabaseService.hasActiveSession) {
      await SupabaseService.client.auth.signOut();
    }
    await UserStorage.setCurrentUserId(null);
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? profileImagePath,
    String? profileImageUrl,
    bool clearProfileImage = false,
    bool clearProfileImageUrl = false,
  }) async {
    final current = state.user;
    if (current == null) return;

    if (usesRemoteDb) {
      await ProfileRepository.update(
        userId: current.id,
        firstName: firstName,
        lastName: lastName,
        profileImageUrl: profileImageUrl,
        clearProfileImage: clearProfileImage || clearProfileImageUrl,
      );
      final user = await ProfileRepository.fetchById(current.id);
      if (user != null) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: user.copyWith(profileImagePath: profileImagePath ?? current.profileImagePath),
        );
      }
      return;
    }

    final updated = current.copyWith(
      firstName: firstName,
      lastName: lastName,
      profileImagePath: profileImagePath,
      clearProfileImage: clearProfileImage,
    );
    await _saveUserLocal(updated);
    state = AuthState(status: AuthStatus.authenticated, user: updated);
  }

  Future<String?> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final current = state.user;
    if (current == null) return 'invalidCredentials';
    if (currentPassword.isEmpty || newPassword.isEmpty) return 'passwordRequired';
    if (newPassword.length < 6) return 'passwordTooShort';
    if (newPassword != confirmNewPassword) return 'passwordMismatch';

    if (usesRemoteDb) {
      try {
        await SupabaseService.client.auth.signInWithPassword(
          email: current.email,
          password: currentPassword,
        );
        await SupabaseService.client.auth.updateUser(
          UserAttributes(password: newPassword),
        );
        return null;
      } on AuthException {
        return 'wrongPassword';
      }
    }

    if (current.passwordHash != hashPassword(currentPassword, current.email)) {
      return 'wrongPassword';
    }

    final updated = current.copyWith(
      passwordHash: hashPassword(newPassword, current.email),
    );
    await _saveUserLocal(updated);
    state = AuthState(status: AuthStatus.authenticated, user: updated);
    return null;
  }

  Future<void> _saveUserLocal(User user) async {
    final users = UserStorage.getUsers();
    final index = users.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      users[index] = user;
      await UserStorage.saveUsers(users);
    }
  }

  static bool get usesRemoteDb =>
      AppConfig.useSupabase &&
      SupabaseService.isReady &&
      SupabaseService.hasActiveSession;
}
