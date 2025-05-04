import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';

part 'doc.g.dart';

@HiveType(typeId: 7)
class Doc extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String ext;
  @HiveField(3)
  final String? desc;
  @HiveField(4)
  final DocCategory category;
  @HiveField(5)
  final String path;
  @HiveField(6)
  final String addedBy;
  @HiveField(7)
  final DateTime addedDate;

  Doc({
    required this.id,
    required this.title,
    required this.ext,
    this.desc,
    required this.category,
    required this.path,
    required this.addedBy,
    required this.addedDate,
  });

  @override
  List<Object?> get props => [id];

  @override
  String get uid => id;
}

@HiveType(typeId: 8)
enum DocCategory {
  @HiveField(0)
  ordinance,
  @HiveField(1)
  budget,
  @HiveField(2)
  minutes,
}
