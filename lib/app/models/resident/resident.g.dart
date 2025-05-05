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
      householdId: fields[4] as String,
      age: fields[5] as int,
      status: fields[6] as CivilStatus,
    );
  }

  @override
  void write(BinaryWriter writer, Resident obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.middleName)
      ..writeByte(4)
      ..write(obj.householdId)
      ..writeByte(5)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.status);
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
