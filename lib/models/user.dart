class User {
  const User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.firstName,
    required this.lastName,
    this.profileImagePath,
  });

  final String id;
  final String email;
  final String passwordHash;
  final String firstName;
  final String lastName;
  final String? profileImagePath;

  String get fullName => '$firstName $lastName'.trim();

  User copyWith({
    String? id,
    String? email,
    String? passwordHash,
    String? firstName,
    String? lastName,
    String? profileImagePath,
    bool clearProfileImage = false,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImagePath: clearProfileImage ? null : (profileImagePath ?? this.profileImagePath),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'passwordHash': passwordHash,
        'firstName': firstName,
        'lastName': lastName,
        'profileImagePath': profileImagePath,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        email: json['email'] as String,
        passwordHash: json['passwordHash'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImagePath: json['profileImagePath'] as String?,
      );
}
