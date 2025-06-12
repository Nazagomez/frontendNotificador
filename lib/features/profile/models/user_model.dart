enum UserRole { admin, user }

class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final UserRole role;

  const UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: _parseUserRole(json['role'] as String),
    );
  }

  static UserRole _parseUserRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }

  bool get isAdmin => role == UserRole.admin;
  bool get isUser => role == UserRole.user;
}
