import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:uuid/uuid.dart';

part 'resident.g.dart';

@HiveType(typeId: 0)
class Resident extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String? middleName;
  @HiveField(4)
  final String householdId;
  @HiveField(5)
  final int age;
  @HiveField(6)
  final CivilStatus status;

  Resident({
    String? id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.householdId,
    required this.age,
    this.status = CivilStatus.single,
  }) : id = id ?? const Uuid().v4();

  @override
  String get uid => id;

  @override
  List<Object?> get props => [id, fullname];

  String get fullname {
    final middleInitial =
        middleName != null && middleName!.trim().isNotEmpty
            ? '${middleName!.trim()[0].toUpperCase()}. '
            : '';
    return '${firstName.trim()} $middleInitial${lastName.trim()}';
  }
}

@HiveType(typeId: 11)
enum CivilStatus {
  @HiveField(0)
  married,
  @HiveField(1)
  single,
  @HiveField(2)
  separated,
  @HiveField(3)
  widdowed,
}

enum Gender { male, female }
