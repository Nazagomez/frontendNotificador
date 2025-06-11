class UserModel {
  final String id;
  final String? email;
  final String role;

  const UserModel({required this.id, this.email, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      role: json['role'] as String,
    );
  }

  bool get isAnonymous => role == 'anonymous';
}
