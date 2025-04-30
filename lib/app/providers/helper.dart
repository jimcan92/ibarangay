import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:ibarangay/app/services/hive.dart';

T? getDataFromBox<T extends AppModel>(String id) {
  return getBox<T>().get(id);
}

Future<void> addDataToBox<T extends AppModel>(T val) async {
  await getBox<T>().put(val.uid, val);
}

Future<void> deleteFromBox<T extends AppModel>(String id) async {
  await getBox<T>().delete(id);
}

Future<void> clearBox<T extends AppModel>() async {
  await getBox<T>().clear();
}

ValueListenable<Box<T>> getListenable<T extends AppModel>() {
  return getBox<T>().listenable();
}
