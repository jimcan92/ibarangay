import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive/hive.dart';
import 'package:ibarangay/app/models/app_model.dart';

part 'user.g.dart';

@HiveType(typeId: 5)
class User extends AppModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final UserRole role;

  User({
    required this.id,
    this.name,
    required this.username,
    required this.password,
    this.role = UserRole.staff,
  });

  @override
  List<Object?> get props => [id];

  @override
  String get uid => id;
}

@HiveType(typeId: 6)
enum UserRole {
  @HiveField(0)
  admin,
  @HiveField(1)
  staff,
  @HiveField(2)
  official;

  String get name {
    switch (this) {
      case UserRole.admin:
        return "Admin";
      case UserRole.staff:
        return "Staff";
      case UserRole.official:
        return "Official";
    }
  }

  Color get color {
    switch (this) {
      case UserRole.admin:
        return Colors.green;
      case UserRole.staff:
        return Colors.blue;
      case UserRole.official:
        return Colors.orange;
    }
  }
}
