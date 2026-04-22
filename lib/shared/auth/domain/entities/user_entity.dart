import 'package:equatable/equatable.dart';

/// User roles that determine which domain/shell the user sees.
enum UserRole { customer, servicer, admin }

/// Domain entity representing an authenticated user.
///
/// This is the clean domain representation — it does NOT contain
/// serialization logic. See [UserModel] in the data layer for that.
class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final UserRole role;
  final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, fullName, email, phone, role, avatarUrl];
}
