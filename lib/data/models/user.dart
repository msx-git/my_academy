import 'role.dart';

class User {
  int id;
  String name;
  dynamic email;
  String phone;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int roleId;
  Role role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.role,
  });
}
