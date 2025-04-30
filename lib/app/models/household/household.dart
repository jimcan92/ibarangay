import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:uuid/uuid.dart';

part "household.g.dart";

@HiveType(typeId: 1)
class Household extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String addressId;
  @HiveField(2)
  final String? headOfFamilyId;
  @HiveField(3)
  final List<String> residentIds;

  Household({
    String? id,
    required this.addressId,
    this.headOfFamilyId,
    this.residentIds = const [],
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, addressId, headOfFamilyId];

  @override
  String get uid => id;
}
