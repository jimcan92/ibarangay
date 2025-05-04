// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CertificateAdapter extends TypeAdapter<Certificate> {
  @override
  final int typeId = 9;

  @override
  Certificate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Certificate(
      id: fields[0] as String,
      type: fields[1] as CertificateType,
      title: fields[2] as String,
      desc: fields[3] as String?,
      issuedTo: fields[4] as String,
      amountPaid: fields[5] as double,
      dateIssued: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Certificate obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.issuedTo)
      ..writeByte(5)
      ..write(obj.amountPaid)
      ..writeByte(6)
      ..write(obj.dateIssued);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CertificateTypeAdapter extends TypeAdapter<CertificateType> {
  @override
  final int typeId = 10;

  @override
  CertificateType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CertificateType.clearance;
      case 1:
        return CertificateType.residency;
      case 2:
        return CertificateType.indigency;
      case 3:
        return CertificateType.soloParent;
      case 4:
        return CertificateType.lowIncome;
      default:
        return CertificateType.clearance;
    }
  }

  @override
  void write(BinaryWriter writer, CertificateType obj) {
    switch (obj) {
      case CertificateType.clearance:
        writer.writeByte(0);
        break;
      case CertificateType.residency:
        writer.writeByte(1);
        break;
      case CertificateType.indigency:
        writer.writeByte(2);
        break;
      case CertificateType.soloParent:
        writer.writeByte(3);
        break;
      case CertificateType.lowIncome:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
