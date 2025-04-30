import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:uuid/uuid.dart';

part 'sitio.g.dart';

@HiveType(typeId: 4)
class Sitio extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  Sitio({String? id, required this.name}) : id = id ?? Uuid().v4();

  @override
  List<Object?> get props => [id];

  @override
  String get uid => id;
}
