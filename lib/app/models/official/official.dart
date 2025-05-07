import 'package:hive/hive.dart';
import 'package:ibarangay/app/models/app_model.dart';

part 'official.g.dart';

@HiveType(typeId: 14)
class Official extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final OfficialType type;
  @HiveField(2)
  final String? committeeOn;

  Official({required this.id, required this.type, this.committeeOn});
  @override
  List<Object?> get props => [id];

  @override
  String get uid => id;
}

@HiveType(typeId: 15)
enum OfficialType {
  @HiveField(0)
  captain,
  @HiveField(1)
  skChairman,
  @HiveField(2)
  secretary,
  @HiveField(3)
  treasurer,
  @HiveField(4)
  firstCouncilor,
  @HiveField(5)
  seconCouncilor,
  @HiveField(6)
  thirdCouncilor,
  @HiveField(7)
  fourthCouncilor,
  @HiveField(8)
  fifthCouncilor,
  @HiveField(9)
  sixthCouncilor,
  @HiveField(10)
  seventhCouncilor;

  String get name {
    switch (this) {
      case OfficialType.captain:
        return "Barangay Captain";
      case OfficialType.skChairman:
        return "Barangay SK Chairman";
      case OfficialType.secretary:
        return "Barangay Secretary";
      case OfficialType.treasurer:
        return "Barangay Treasurer";
      case OfficialType.firstCouncilor:
        return "Barangay Councilor";
      case OfficialType.seconCouncilor:
        return "Barangay Councilor";
      case OfficialType.thirdCouncilor:
        return "Barangay Councilor";
      case OfficialType.fourthCouncilor:
        return "Barangay Councilor";
      case OfficialType.fifthCouncilor:
        return "Barangay Councilor";
      case OfficialType.sixthCouncilor:
        return "Barangay Councilor";
      case OfficialType.seventhCouncilor:
        return "Barangay Councilor";
    }
  }
}
