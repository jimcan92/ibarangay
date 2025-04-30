import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/address/address.dart';
import 'package:ibarangay/app/providers/helper.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'addresses.g.dart';

typedef Model = Address;

@riverpod
class AddressesBox extends _$AddressesBox {
  @override
  ValueListenable<Box<Model>> build() => getBox<Model>().listenable();

  void add(Model val) async {
    await addDataToBox<Model>(val);
  }

  void delete(String id) async {
    await deleteFromBox<Model>(id);
  }

  Model? get(String id) {
    return getDataFromBox<Model>(id);
  }

  void clear() async {
    await clearBox<Model>();
  }
}
