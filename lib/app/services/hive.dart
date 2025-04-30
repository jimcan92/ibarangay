import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/address/address.dart';
import 'package:ibarangay/app/models/household/household.dart';
import 'package:ibarangay/app/models/purok/purok.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/models/sitio/sitio.dart';
import 'package:ibarangay/app/models/user/user.dart';
import 'package:ibarangay/utils/user.dart';

import '../models/app_model.dart';

final Map<Type, String> boxNameMap = {
  Resident: 'residents',
  Household: 'households',
  Address: 'addresses',
  Purok: 'puroks',
  Sitio: 'sitios',
  User: 'users',
};

Box<T> getBox<T extends AppModel>() {
  final name = boxNameMap[T];
  if (name == null) {
    throw Exception('Box name not registered for type $T');
  }
  return Hive.box<T>(name);
}

Future<void> openBox<T extends AppModel>() async {
  final name = boxNameMap[T];
  if (name == null) {
    throw Exception('Box name not registered for type $T');
  }
  await Hive.openBox<T>(name);
}

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ResidentAdapter());
    Hive.registerAdapter(HouseholdAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(PurokAdapter());
    Hive.registerAdapter(SitioAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserRoleAdapter());

    await openBox<Resident>();
    await openBox<Household>();
    await openBox<Address>();
    await openBox<Purok>();
    await openBox<Sitio>();
    await openBox<User>();

    if (getBox<User>().isEmpty) {
      var admin = User(
        id: 'admin',
        username: 'jimcan',
        password: hashPassword('admin'),
        name: 'jimcan',
        role: UserRole.admin,
      );

      await getBox<User>().put(admin.uid, admin);
    }
  }
}
