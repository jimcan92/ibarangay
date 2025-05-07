import 'package:hive/hive.dart';
import 'package:ibarangay/app/models/app_model.dart';

part 'certificate.g.dart';

@HiveType(typeId: 9)
class Certificate extends AppModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final CertificateType type;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? desc;
  @HiveField(4)
  final String issuedTo;
  @HiveField(5)
  final double amountPaid;
  @HiveField(6)
  final DateTime dateIssued;
  @HiveField(7)
  final String? purpose;

  Certificate({
    required this.id,
    this.type = CertificateType.clearance,
    required this.title,
    this.desc,
    required this.issuedTo,
    this.amountPaid = 0,
    required this.dateIssued,
    this.purpose,
  });

  @override
  List<Object?> get props => [id];

  @override
  String get uid => id;
}

@HiveType(typeId: 10)
enum CertificateType {
  @HiveField(0)
  clearance,
  @HiveField(1)
  residency,
  @HiveField(2)
  indigency,
  @HiveField(3)
  soloParent,
  @HiveField(4)
  lowIncome;

  String get name {
    switch (this) {
      case CertificateType.clearance:
        return "Barangay Clearance";
      case CertificateType.residency:
        return "Certificate of Recidency";
      case CertificateType.indigency:
        return "Certificate of Indigency";
      case CertificateType.soloParent:
        return "Solo Parent Certificate";
      case CertificateType.lowIncome:
        return "Low Income Certificate";
    }
  }
}
