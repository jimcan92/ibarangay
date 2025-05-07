import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/app_model.dart';
import 'package:ibarangay/utils/age.dart';
import 'package:ibarangay/utils/extensions.dart';
import 'package:uuid/uuid.dart';

part 'resident.g.dart';

@HiveType(typeId: 0)
class Resident extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String? middleName;
  @HiveField(4)
  final String? suffix;
  @HiveField(5)
  final Gender gender;
  @HiveField(6)
  final CivilStatus civilStatus;
  @HiveField(7)
  final DateTime birthDate;
  @HiveField(8)
  final String? birthPlace;
  @HiveField(9)
  final String nationality;
  @HiveField(10)
  final String? religion;
  @HiveField(11)
  final String? contactNumber;
  @HiveField(12)
  final String? occupation;
  @HiveField(13)
  final String? nationalIdNumber;
  @HiveField(14)
  final String? purok;
  @HiveField(15)
  final String? houseNo;
  @HiveField(16)
  final String? street;
  @HiveField(17)
  final String? profilePath;
  @HiveField(18)
  final bool updatedProfile;

  Resident({
    String? id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.suffix,
    required this.gender,
    this.civilStatus = CivilStatus.single,
    required this.birthDate,
    this.birthPlace,
    this.nationality = "Filipino",
    this.religion,
    this.contactNumber,
    this.occupation,
    this.nationalIdNumber,
    this.purok,
    this.houseNo,
    this.street,
    this.profilePath,
    this.updatedProfile = false,
  }) : id = id ?? const Uuid().v4();

  @override
  String get uid => id;

  @override
  List<Object?> get props => [id, fullname];

  String get fullname {
    final middleInitial =
        middleName != null && middleName!.trim().isNotEmpty
            ? '${middleName!.trim()[0].toUpperCase()}. '
            : '';
    return '${firstName.trim().title()} $middleInitial${lastName.trim().title()}';
  }

  int get age => getAge(birthDate);

  Resident copyWith({
    String? firstName,
    String? lastName,
    String? middleName,
    String? suffix,
    Gender? gender,
    CivilStatus? civilStatus,
    DateTime? birthDate,
    String? birthPlace,
    String? nationality,
    String? religion,
    String? contactNumber,
    String? occupation,
    String? nationalIdNumber,
    String? purok,
    String? houseNo,
    String? street,
    String? profilePath,
    bool? updatedProfile,
  }) {
    return Resident(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      suffix: suffix ?? this.suffix,
      gender: gender ?? this.gender,
      civilStatus: civilStatus ?? this.civilStatus,
      birthDate: birthDate ?? this.birthDate,
      birthPlace: birthPlace ?? this.birthPlace,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      contactNumber: contactNumber ?? this.contactNumber,
      occupation: occupation ?? this.occupation,
      nationalIdNumber: nationalIdNumber ?? this.nationalIdNumber,
      purok: purok ?? this.purok,
      houseNo: houseNo ?? this.houseNo,
      street: street ?? this.street,
      profilePath: profilePath ?? this.profilePath,
      updatedProfile: updatedProfile ?? this.updatedProfile,
    );
  }
}

@HiveType(typeId: 11)
enum CivilStatus {
  @HiveField(0)
  married,
  @HiveField(1)
  single,
  @HiveField(2)
  separated,
  @HiveField(3)
  widdowed,
}

@HiveType(typeId: 13)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
}
