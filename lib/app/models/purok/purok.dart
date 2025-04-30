import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:uuid/uuid.dart';

part 'purok.g.dart';

@HiveType(typeId: 3)
class Purok extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  Purok({String? id, required this.name}) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, name];

  @override
  String get uid => id;
}
