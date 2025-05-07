// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResidentAdapter extends TypeAdapter<Resident> {
  @override
  final int typeId = 0;

  @override
  Resident read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resident(
      id: fields[0] as String?,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      middleName: fields[3] as String?,
      suffix: fields[4] as String?,
      gender: fields[5] as Gender,
      civilStatus: fields[6] as CivilStatus,
      birthDate: fields[7] as DateTime,
      birthPlace: fields[8] as String?,
      nationality: fields[9] as String,
      religion: fields[10] as String?,
      contactNumber: fields[11] as String?,
      occupation: fields[12] as String?,
      nationalIdNumber: fields[13] as String?,
      purok: fields[14] as String?,
      houseNo: fields[15] as String?,
      street: fields[16] as String?,
      profilePath: fields[17] as String?,
      updatedProfile: fields[18] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Resident obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.suffix)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.civilStatus)
      ..writeByte(7)
      ..write(obj.birthDate)
      ..writeByte(8)
      ..write(obj.birthPlace)
      ..writeByte(9)
      ..write(obj.nationality)
      ..writeByte(10)
      ..write(obj.religion)
      ..writeByte(11)
      ..write(obj.contactNumber)
      ..writeByte(12)
      ..write(obj.occupation)
      ..writeByte(13)
      ..write(obj.nationalIdNumber)
      ..writeByte(14)
      ..write(obj.purok)
      ..writeByte(15)
      ..write(obj.houseNo)
      ..writeByte(16)
      ..write(obj.street)
      ..writeByte(17)
      ..write(obj.profilePath)
      ..writeByte(18)
      ..write(obj.updatedProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResidentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CivilStatusAdapter extends TypeAdapter<CivilStatus> {
  @override
  final int typeId = 11;

  @override
  CivilStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CivilStatus.married;
      case 1:
        return CivilStatus.single;
      case 2:
        return CivilStatus.separated;
      case 3:
        return CivilStatus.widdowed;
      default:
        return CivilStatus.married;
    }
  }

  @override
  void write(BinaryWriter writer, CivilStatus obj) {
    switch (obj) {
      case CivilStatus.married:
        writer.writeByte(0);
        break;
      case CivilStatus.single:
        writer.writeByte(1);
        break;
      case CivilStatus.separated:
        writer.writeByte(2);
        break;
      case CivilStatus.widdowed:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CivilStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final int typeId = 13;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.male:
        writer.writeByte(0);
        break;
      case Gender.female:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
