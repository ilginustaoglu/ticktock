import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(status: AuthStatus.loading)) {
    _restoreSession();
  }

  void _restoreSession() {
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
      UserStorage.setCurrentUserId(null);
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
    return null;
  }

  Future<void> logOut() async {
    await UserStorage.setCurrentUserId(null);
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? profileImagePath,
    bool clearProfileImage = false,
  }) async {
    final current = state.user;
    if (current == null) return;

    final updated = current.copyWith(
      firstName: firstName,
      lastName: lastName,
      profileImagePath: profileImagePath,
      clearProfileImage: clearProfileImage,
    );
    await _saveUser(updated);
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
    if (current.passwordHash != hashPassword(currentPassword, current.email)) {
      return 'wrongPassword';
    }

    final updated = current.copyWith(
      passwordHash: hashPassword(newPassword, current.email),
    );
    await _saveUser(updated);
    state = AuthState(status: AuthStatus.authenticated, user: updated);
    return null;
  }

  Future<void> _saveUser(User user) async {
    final users = UserStorage.getUsers();
    final index = users.indexWhere((u) => u.id == user.id);
    if (index >= 0) {
      users[index] = user;
      await UserStorage.saveUsers(users);
    }
  }
}
