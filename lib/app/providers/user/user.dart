import 'package:ibarangay/app/models/user/user.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/utils/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

@riverpod
class UserBox extends _$UserBox {
  @override
  User? build() => null;

  Future<bool> login(String username, String password) async {
    final hashed = hashPassword(password);

    final user =
        getBox<User>().values
            .where((u) => u.username == username && u.password == hashed)
            .firstOrNull;

    state = user;

    return user != null;
  }

  Future<void> logout() async {
    state = null;
  }
}
