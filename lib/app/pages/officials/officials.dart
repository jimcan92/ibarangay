import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:ibarangay/app/models/barangay_details/barangay_details.dart';
import 'package:ibarangay/app/models/official/official.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/barangay_details.dart';

class Officials extends StatefulWidget {
  const Officials({super.key});

  @override
  State<Officials> createState() => _OfficialsState();
}

class _OfficialsState extends State<Officials> {
  @override
  Widget build(BuildContext context) {
    final details = getBox<BarangayDetails>().get("details");
    final theme = FluentTheme.of(context);

    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text("Barangay Officials")),

      children:
          details == null
              ? [
                Center(
                  child: InfoBar(
                    title: Text("Barangay Details Not Set."),
                    content: Text("You need set your barangay details first."),
                    severity: InfoBarSeverity.warning,
                    action: ThemedButton.primary(
                      child: Text("Set"),
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return BarangayDetailsDialog();
                          },
                        );

                        setState(() {});
                      },
                    ),
                  ),
                ),
              ]
              : [
                Image.file(
                  File(details.logoPath),
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "images/logo.png",
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return FlutterLogo(size: 100);
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Barangay ${details.name}",
                  textAlign: TextAlign.center,
                  style: theme.typography.subtitle,
                ),
                Text(
                  "${details.city}, ${details.province}, ${details.zipCode}",
                  textAlign: TextAlign.center,
                  style: theme.typography.caption,
                ),
                Row(children: [OfficialCard()]),
              ],
    );
  }
}

class OfficialCard extends StatelessWidget {
  const OfficialCard({super.key, required this.official});

  final Official official;

  @override
  Widget build(BuildContext context) {
    final resident = getBox<Resident>().get(official.id);

    return Card(
      // padding: EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.file(
              File(resident?.profilePath),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Jimboy Cantila',
            style: FluentTheme.of(context).typography.subtitle,
            textAlign: TextAlign.center,
          ),
          Text(
            "Barangay Captain",
            style: FluentTheme.of(context).typography.caption,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            '📞 09924367264',
            style: FluentTheme.of(context).typography.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
