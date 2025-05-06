import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/purok/purok.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/utils/nationalities.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Residents extends StatelessWidget {
  const Residents({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text("Residents"),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          // isCompact: true,
          primaryItems: [
            CommandBarButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return ResidentDialog();
                  },
                );
              },
              icon: Icon(FluentIcons.add),
              label: Text("Add New"),
            ),
          ],
        ),
      ),
      content: ValueListenableBuilder(
        valueListenable: getBox<Resident>().listenable(),
        builder: (context, residentsBox, child) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                gridLineColor: FluentTheme.of(context).cardColor,
              ),
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: ResidentsDataSource(
                  residents: residentsBox.values.toList(),
                ),
                columns: [
                  GridColumn(
                    columnName: 'id',
                    label: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text("ID"),
                    ),
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                  ),
                  GridColumn(
                    columnName: 'name',
                    label: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text("Name"),
                    ),
                    columnWidthMode: ColumnWidthMode.fill,
                  ),
                  GridColumn(
                    columnName: 'age',
                    label: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text("Age"),
                    ),
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                  ),
                  GridColumn(
                    columnName: 'status',
                    label: Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Text("Status"),
                    ),
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResidentDialog extends StatefulWidget {
  const ResidentDialog({super.key});

  @override
  State<ResidentDialog> createState() => _ResidentDialogState();
}

class _ResidentDialogState extends State<ResidentDialog> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController middleNameController;

  File? selectedLogo;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return ContentDialog(
      constraints: BoxConstraints(maxWidth: 1000),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New Resident"),
          IconButton(icon: Icon(FluentIcons.clear), onPressed: context.pop),
        ],
      ),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                SizedBox(
                  // color: Colors.red,
                  width: 200,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.cardColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Photo", style: theme.typography.subtitle),
                        selectedLogo == null
                            ? Icon(FluentIcons.photo2, size: 150)
                            : Image.file(
                              File(selectedLogo!.path),
                              errorBuilder: (context, o, t) {
                                return Icon(FluentIcons.photo2);
                              },
                            ),
                        Button(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,

                            children: [
                              Icon(FluentIcons.open_folder_horizontal),
                              Text("Browse"),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: FluentTheme.of(context).cardColor,
                      ),
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Personal Information",
                          style: theme.typography.subtitle,
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: InfoLabel(
                                label: "Last Name",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "First Name",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Middle Name",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Suffix",
                                child: TextFormBox(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            InfoLabel(
                              label: "Gender",
                              child: ComboBox<Gender>(
                                onChanged: (val) {},
                                items:
                                    Gender.values.map((g) {
                                      return ComboBoxItem(
                                        value: g,
                                        child: Text(g.name),
                                      );
                                    }).toList(),
                              ),
                            ),
                            InfoLabel(
                              label: "Civil Status",
                              child: ComboBox<CivilStatus>(
                                onChanged: (val) {},
                                items:
                                    CivilStatus.values.map((cs) {
                                      return ComboBoxItem(
                                        value: cs,
                                        child: Text(cs.name),
                                      );
                                    }).toList(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Birth Date",
                                child: DatePicker(selected: DateTime.now()),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Birth place",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Contact No.",
                                child: TextFormBox(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            InfoLabel(
                              label: "Nationality",
                              child: ComboBox<String>(
                                onChanged: (v) {},
                                items:
                                    nationalities.map((n) {
                                      return ComboBoxItem(
                                        value: n,
                                        child: Text(n),
                                      );
                                    }).toList(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Religion",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Occupation",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Family Monthly Income",
                                child: TextFormBox(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            InfoLabel(
                              label: "PWD?",
                              child: ComboBox<bool>(
                                onChanged: (v) {},
                                items: [
                                  ComboBoxItem(value: true, child: Text("Yes")),
                                  ComboBoxItem(value: false, child: Text("No")),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "PWD Number",
                                child: TextFormBox(),
                              ),
                            ),
                            InfoLabel(
                              label: "Solo Parent?",
                              child: ComboBox<bool>(
                                onChanged: (v) {},
                                items: [
                                  ComboBoxItem(value: true, child: Text("Yes")),
                                  ComboBoxItem(value: false, child: Text("No")),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Solo Parent ID No.",
                                child: TextFormBox(),
                              ),
                            ),
                            InfoLabel(
                              label: "Indigent?",
                              child: ComboBox<bool>(
                                onChanged: (v) {},
                                items: [
                                  ComboBoxItem(value: true, child: Text("Yes")),
                                  ComboBoxItem(value: false, child: Text("No")),
                                ],
                              ),
                            ),
                            InfoLabel(
                              label: "4Ps Member?",
                              child: ComboBox<bool>(
                                onChanged: (v) {},
                                items: [
                                  ComboBoxItem(value: true, child: Text("Yes")),
                                  ComboBoxItem(value: false, child: Text("No")),
                                ],
                              ),
                            ),
                            InfoLabel(
                              label: "Registered Voter?",
                              child: ComboBox<bool>(
                                onChanged: (v) {},
                                items: [
                                  ComboBoxItem(value: true, child: Text("Yes")),
                                  ComboBoxItem(value: false, child: Text("No")),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: InfoLabel(
                                label: "National ID No.",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Senior Citizen ID No.",
                                child: TextFormBox(),
                              ),
                            ),
                            InfoLabel(label: "Purok", child: PurokSelector()),
                            Expanded(
                              child: InfoLabel(
                                label: "House No.",
                                child: TextFormBox(),
                              ),
                            ),
                            Expanded(
                              child: InfoLabel(
                                label: "Street",
                                child: TextFormBox(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [Button(onPressed: context.pop, child: Text("Cancel"))],
    );
  }
}

class PurokSelector extends StatefulWidget {
  const PurokSelector({super.key});

  @override
  State<PurokSelector> createState() => _PurokSelectorState();
}

class _PurokSelectorState extends State<PurokSelector> {
  final comboboxKey = GlobalKey<ComboBoxState>();

  Purok? selected;

  void onSelect(Purok? val) {
    if (val == null || val == selected) return;

    setState(() {
      selected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getBox<Purok>().listenable(),
      builder: (context, puroksBox, child) {
        return ComboBox<Purok>(
          key: comboboxKey,
          value: selected,
          onChanged: onSelect,

          items: [
            ComboBoxItem(
              enabled: false,
              child: Button(
                child: Row(
                  spacing: 8,
                  children: [Icon(FluentIcons.add), Text("New Purok")],
                ),
                onPressed: () async {
                  comboboxKey.currentState?.closePopup();
                  final purok = await showDialog<Purok>(
                    context: context,
                    builder: (context) {
                      return NewPurokDialog();
                    },
                  );

                  if (purok != null) {
                    setState(() {
                      selected = purok;
                    });
                  }
                },
              ),
              // child: SizedBox(
              //   width: 100,
              //   child: TextBox(
              //     placeholder: "Add New Purok",
              //     onSubmitted: (value) {
              //       print(value);
              //       values.add(value);
              //       comboboxKey.currentState?.closePopup();
              //       setState(() {});
              //     },
              //   ),
              // ),
            ),
            ...puroksBox.values.map((p) {
              return ComboBoxItem(value: p, child: Text(p.name));
            }),
          ],
        );
      },
    );
  }
}

class NewPurokDialog extends StatefulWidget {
  const NewPurokDialog({super.key});

  @override
  State<NewPurokDialog> createState() => _NewPurokDialogState();
}

class _NewPurokDialogState extends State<NewPurokDialog> {
  late TextEditingController controller;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text("New Purok"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: formKey,
            child: InfoLabel(
              label: "Purok Name",
              child: TextFormBox(
                controller: controller,
                onFieldSubmitted: (value) async {
                  final purok = await onSave();
                  if (purok != null && context.mounted) context.pop(purok);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Don't add a purok with no name";
                  }

                  return null;
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        Button(onPressed: context.pop, child: Text("Cancel")),
        ThemedButton.primary(
          onPressed: () async {
            final purok = await onSave();
            if (purok != null && context.mounted) context.pop(purok);
          },
          child: Text("Save"),
        ),
      ],
    );
  }

  Future<Purok?> onSave() async {
    if (!formKey.currentState!.validate()) return null;

    final purok = Purok(name: controller.text);

    await getBox<Purok>().add(purok);

    return purok;
  }
}

class ResidentsDataSource extends DataGridSource {
  ResidentsDataSource({required List<Resident> residents}) {
    _residentsData =
        residents.map((r) {
          return DataGridRow(
            cells: [
              DataGridCell(columnName: "id", value: r.id),
              DataGridCell(columnName: "name", value: r.fullname),
              DataGridCell(columnName: "age", value: r.age),
              DataGridCell(columnName: "status", value: r.status.name),
            ],
          );
        }).toList();
  }
  List<DataGridRow> _residentsData = [];
  @override
  List<DataGridRow> get rows => _residentsData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((e) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8.0),
              child: Text(e.value.toString()),
            );
          }).toList(),
    );
  }
}
