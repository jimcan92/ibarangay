import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';

part 'barangay_details.g.dart';

@HiveType(typeId: 12)
class BarangayDetails extends AppModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final String province;
  @HiveField(3)
  final int zipCode;
  @HiveField(4)
  final String logoPath;

  BarangayDetails({
    required this.name,
    required this.city,
    required this.province,
    required this.zipCode,
    required this.logoPath,
  });

  @override
  List<Object?> get props => [name];

  @override
  String get uid => name;
}
