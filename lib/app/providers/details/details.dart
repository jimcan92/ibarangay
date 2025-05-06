import 'package:ibarangay/app/models/barangay_details/barangay_details.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'details.g.dart';

@riverpod
class BrgyDetails extends _$BrgyDetails {
  @override
  BarangayDetails? build() => getBox<BarangayDetails>().get("details");
}
