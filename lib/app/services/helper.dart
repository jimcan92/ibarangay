import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

Future<PlatformFile?> pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'pdf',
      // 'docx',
      // 'xlsx',
      // 'odt',
      // 'csv',
    ],
  );

  if (result != null) {
    return result.files.single;
  }

  return null;
}

Future<PlatformFile?> pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['png'],
  );

  if (result != null) {
    return result.files.single;
  }

  return null;
}

Future<String> saveDocumentTo(File file, String path, String filename) async {
  // await Directory(path).create(recursive: true);
  final folder = Directory(path);
  if (!folder.existsSync()) {
    await folder.create(recursive: true);
  }

  final stringPath = "$path\\$filename";

  final res = await file.copy(stringPath);

  return res.path;
}

Future<void> deleteDocumentFrom(String path) async {
  await File(path).delete(recursive: true);
}
