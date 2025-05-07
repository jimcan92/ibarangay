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

  Official({
    required this.id,
    this.type = OfficialType.councelor,
    this.committeeOn,
  });
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
  councelor,
}
