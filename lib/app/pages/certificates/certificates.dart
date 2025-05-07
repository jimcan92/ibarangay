import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/certificate/certificate.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/services/pdf.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/utils/extensions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Certificates extends StatefulWidget {
  const Certificates({super.key});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  Map<int, bool> selected = {0: true, 1: true, 2: true, 3: true, 4: true};

  void toggleSelected(int index) {
    selected[index] = !selected[index]!;
    setState(() {});
  }

  void toggleSelectAll() {
    final allActive = selected.entries.every((e) => e.value);

    if (allActive) {
      selected.forEach((i, _) {
        selected[i] = false;
      });
    } else {
      selected.forEach((i, _) {
        selected[i] = true;
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final allActive = selected.entries.every((e) => e.value);

    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Certificates & Clearances'),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return NewCertificateDialog();
                  },
                );
              },
              label: Text("New Clearance/Certificate"),
              icon: Icon(FluentIcons.add),
            ),
          ],
        ),
      ),
      content: ValueListenableBuilder(
        valueListenable: getBox<Certificate>().listenable(),
        builder: (context, certificatesBox, child) {
          final all = certificatesBox.values.toList();
          final clearances = all.where(
            (c) => c.type == CertificateType.clearance,
          );
          final indigencies = all.where(
            (c) => c.type == CertificateType.indigency,
          );
          final lowIncomes = all.where(
            (c) => c.type == CertificateType.lowIncome,
          );
          final residencies = all.where(
            (c) => c.type == CertificateType.residency,
          );
          final soloParents = all.where(
            (c) => c.type == CertificateType.soloParent,
          );

          final lengths = [
            clearances.length,
            indigencies.length,
            lowIncomes.length,
            residencies.length,
            soloParents.length,
          ];

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Issued Certificates & Clearances',
                  style: FluentTheme.of(context).typography.subtitle,
                ),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Button(
                      // backgroundColor: Colors.accentColors[e.$1 + 1]
                      // .withAlpha(150),
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          allActive
                              ? Colors.accentColors[1].basedOnLuminance()
                              : Colors.accentColors[1]
                                  .basedOnLuminance()
                                  .withAlpha(100),
                        ),

                        backgroundColor: WidgetStateProperty.resolveWith((
                          state,
                        ) {
                          if (state.isHovered) {
                            return allActive
                                ? Colors.accentColors[1]
                                : Colors.accentColors[1].withAlpha(80);
                          }
                          return allActive
                              ? Colors.accentColors[1].withAlpha(220)
                              : Colors.accentColors[1].withAlpha(40);
                        }),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                      ),
                      onPressed: toggleSelectAll,
                      child: Text('All: ${all.length}'),
                    ),
                    ...CertificateType.values.indexed.map((e) {
                      return Button(
                        // backgroundColor: Colors.accentColors[e.$1 + 1]
                        // .withAlpha(150),
                        style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                            selected[e.$1]!
                                ? Colors.accentColors[e.$1 + 2]
                                    .basedOnLuminance()
                                : Colors.accentColors[e.$1 + 2]
                                    .basedOnLuminance()
                                    .withAlpha(100),
                          ),

                          backgroundColor: WidgetStateProperty.resolveWith((
                            state,
                          ) {
                            if (state.isHovered) {
                              return selected[e.$1]!
                                  ? Colors.accentColors[e.$1 + 2]
                                  : Colors.accentColors[e.$1 + 2].withAlpha(80);
                            }
                            return selected[e.$1]!
                                ? Colors.accentColors[e.$1 + 2].withAlpha(220)
                                : Colors.accentColors[e.$1 + 2].withAlpha(40);
                          }),
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          ),
                        ),
                        child: Text('${e.$2.name}: ${lengths[e.$1]}'),
                        onPressed: () {
                          toggleSelected(e.$1);
                        },
                      );
                    }),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: all.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cert = all[index];

                      return TileButton(
                        leading: FluentIcons.certificate,
                        title: cert.title,
                        subtitle:
                            "Issued to ${getBox<Resident>().get(cert.issuedTo)?.fullname} on ${DateFormat("MMM d, y").format(cert.dateIssued)}",
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NewCertificateDialog extends StatefulWidget {
  const NewCertificateDialog({super.key});

  @override
  State<NewCertificateDialog> createState() => _NewCertificateDialogState();
}

class _NewCertificateDialogState extends State<NewCertificateDialog> {
  late final List<Resident> residents;

  late TextEditingController purposeController;

  Resident? selectedResident;
  CertificateType certType = CertificateType.clearance;
  File? generated;
  DateTime issuedDate = DateTime.now();

  @override
  void initState() {
    residents = getBox<Resident>().values.toList();
    purposeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 1000),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New Certificate/Clearance"),
          IconButton(icon: Icon(FluentIcons.clear), onPressed: context.pop),
        ],
      ),
      content: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: InfoLabel(
                  label: "Resident",
                  child: AutoSuggestBox(
                    onSelected: (val) {
                      setState(() {
                        selectedResident = val.value;
                      });
                    },
                    items:
                        residents.map((r) {
                          return AutoSuggestBoxItem(
                            value: r,
                            label: r.fullname,
                          );
                        }).toList(),
                  ),
                ),
              ),
              InfoLabel(
                label: "Type",
                child: ComboBox(
                  value: certType,
                  onChanged: (val) {
                    if (val == null || certType == val) return;

                    setState(() {
                      certType = val;
                    });
                  },
                  items:
                      CertificateType.values.map((t) {
                        return ComboBoxItem(
                          value: t,
                          child: Text(t.name.title()),
                        );
                      }).toList(),
                ),
              ),
              InfoLabel(
                label: "Issued Date",
                child: DatePicker(
                  selected: issuedDate,
                  onChanged: (value) {
                    if (issuedDate == value) return;

                    setState(() {
                      issuedDate = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: InfoLabel(
                  label: "Purpose",
                  child: TextBox(controller: purposeController),
                ),
              ),
              ThemedButton.primary(
                onPressed: () async {
                  if (selectedResident == null) return;

                  generated = await generateBarangayClearance(
                    issuedTo: selectedResident!,
                    date: issuedDate,
                  );

                  setState(() {});
                },
                child: Text("Generate"),
              ),
            ],
          ),
          Expanded(
            child:
                generated == null
                    ? Center(
                      child: Text(
                        "Generate PDF",
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                    )
                    : SfPdfViewer.file(File(generated!.path)),
          ),
        ],
      ),
      actions: [
        Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton.primary(
          onPressed: () async {
            if (selectedResident == null || generated == null) return;

            final cert = Certificate(
              id:
                  "${selectedResident!.id}_${certType.name.replaceAll(" ", "_")}_${issuedDate.toIso8601String().replaceAll(" ", "_")}",
              title: certType.name,
              issuedTo: selectedResident!.id,
              dateIssued: issuedDate,
              purpose: purposeController.text,
            );

            await getBox<Certificate>().put(cert.id, cert);

            if (context.mounted) {
              context.pop();
            }
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
