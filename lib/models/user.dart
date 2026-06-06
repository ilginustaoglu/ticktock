class User {
  const User({
    required this.id,
    required this.email,
    this.passwordHash,
    required this.firstName,
    required this.lastName,
    this.profileImagePath,
    this.profileImageUrl,
    this.emailConfirmedAt,
  });

  final String id;
  final String email;
  /// Yerel Hive auth için; Supabase kullanıldığında null.
  final String? passwordHash;
  final String firstName;
  final String lastName;
  final String? profileImagePath;
  final String? profileImageUrl;
  final DateTime? emailConfirmedAt;

  String get fullName => '$firstName $lastName'.trim();

  bool get isEmailConfirmed => emailConfirmedAt != null;

  /// Profil resmi: önce yerel dosya, yoksa uzak URL.
  String? get displayImagePath => profileImagePath;
  String? get displayImageUrl => profileImageUrl;

  User copyWith({
    String? id,
    String? email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    String? profileImagePath,
    String? profileImageUrl,
    DateTime? emailConfirmedAt,
    bool clearProfileImage = false,
    bool clearProfileImageUrl = false,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImagePath: clearProfileImage ? null : (profileImagePath ?? this.profileImagePath),
      profileImageUrl: clearProfileImageUrl ? null : (profileImageUrl ?? this.profileImageUrl),
      emailConfirmedAt: emailConfirmedAt ?? this.emailConfirmedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'passwordHash': passwordHash,
        'firstName': firstName,
        'lastName': lastName,
        'profileImagePath': profileImagePath,
        'profileImageUrl': profileImageUrl,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        email: json['email'] as String,
        passwordHash: json['passwordHash'] as String?,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImagePath: json['profileImagePath'] as String?,
        profileImageUrl: json['profileImageUrl'] as String?,
      );

  factory User.fromSupabase({
    required Map<String, dynamic> profile,
    required String email,
    DateTime? emailConfirmedAt,
  }) =>
      User(
        id: profile['id'] as String,
        email: (profile['email'] as String?) ?? email,
        firstName: profile['first_name'] as String? ?? '',
        lastName: profile['last_name'] as String? ?? '',
        profileImageUrl: profile['profile_image_url'] as String?,
        emailConfirmedAt: emailConfirmedAt ??
            _parseDateTime(profile['email_confirmed_at']),
      );

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }
}
