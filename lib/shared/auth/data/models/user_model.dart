import 'package:lamma3ly/shared/auth/domain/entities/user_entity.dart';

/// Data-layer model for [UserEntity] with JSON serialization.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.role,
    super.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: _parseRole(json['role'] as String),
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'role': role.name,
      'avatar_url': avatarUrl,
    };
  }

  static UserRole _parseRole(String role) {
    return switch (role) {
      'customer' => UserRole.customer,
      'servicer' => UserRole.servicer,
      'admin' => UserRole.admin,
      _ => UserRole.customer,
    };
  }
}
