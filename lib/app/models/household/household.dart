import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';

part "household.g.dart";

@HiveType(typeId: 1)
class Household extends AppModel {
  @HiveField(0)
  final String id;
  // @HiveField(1)
  // final String? headOfFamilyId;
  // @HiveField(1)
  // final String addressId;
  @HiveField(1)
  final List<String> members;

  Household({
    required this.id,
    // required this.addressId,
    // this.headOfFamilyId,
    this.members = const [],
  });

  @override
  List<Object?> get props => [id];

  @override
  String get uid => id;
}

// @HiveType(typeId: 14)
// class HouseholdMember extends AppModel {
//   @HiveField(0)
//   final String id;
//   @HiveField(1)
//   final HouseholdMemberType type;
//   @HiveField(2)
//   final bool isHead;

//   HouseholdMember({required this.id, required this.type, this.isHead = false});

//   @override
//   List<Object?> get props => [id];

//   @override
//   String get uid => id;
// }

// @HiveType(typeId: 15)
// enum HouseholdMemberType {
//   @HiveField(0)
//   husband,
//   @HiveField(1)
//   wife,
//   @HiveField(2)
//   grandFather,
//   @HiveField(3)
//   grandMother,
//   @HiveField(4)
//   grandChild,
//   @HiveField(5)
//   child,
// }
