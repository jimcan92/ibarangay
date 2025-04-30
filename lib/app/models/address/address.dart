import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/config.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:uuid/uuid.dart';

part 'address.g.dart';

@HiveType(typeId: 2)
class Address extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String street;
  @HiveField(2)
  final String purokId;
  @HiveField(3)
  final String barangay;
  @HiveField(4)
  final String municipality;
  @HiveField(5)
  final String province;

  Address({
    String? id,
    required this.street,
    required this.purokId,
    this.barangay = kDefaultBarangay,
    this.municipality = kDefaultMunicipality,
    this.province = kDefaultProvince,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [
    id,
    street,
    purokId,
    barangay,
    municipality,
    province,
  ];

  @override
  String get uid => id;
}
