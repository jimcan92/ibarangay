import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/action/confirm_delete.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/resident.dart';
import 'package:ibarangay/utils/extensions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Individuals extends StatelessWidget {
  const Individuals({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24, top: 24, right: 24),
          child: TileButton(
            leading: FluentIcons.account_management,
            title: "Add New Resident",
            subtitle: "Click to open new resident information dialog.",
            trailing: FluentIcons.add,
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return ResidentDialog();
                },
              );
            },
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
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

                    // selectionMode: SelectionMode.multiple,
                    source: ResidentsDataSource(
                      context: context,
                      residents: residentsBox.values.toList(),
                    ),
                    columns: [
                      GridColumn(
                        columnName: 'actions',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Actions"),
                        ),
                        maximumWidth: 80,
                      ),
                      GridColumn(
                        columnName: 'name',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Name"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'gender',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Gender"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'civilStatus',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Civil Status"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'birthdate',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Birthdate"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'age',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Age"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'birthplace',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Birthplace"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'contactNo',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Contact No."),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'nationality',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Nationality"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'religion',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Religion"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'occupation',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Occupation"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'nationalIdNo',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("National ID Number"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'purok',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Purok"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'houseNo',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("House No"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                      GridColumn(
                        columnName: 'street',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Street"),
                        ),
                        columnWidthMode: ColumnWidthMode.auto,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ResidentsDataSource extends DataGridSource {
  ResidentsDataSource({
    required this.context,
    required List<Resident> residents,
  }) {
    _residentsData =
        residents.map((r) {
          return DataGridRow(
            cells: [
              DataGridCell<Widget>(
                columnName: "actions",
                value: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        FluentIcons.edit,
                        color: Colors.warningPrimaryColor,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ResidentDialog(resident: r);
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        FluentIcons.delete,
                        color: Colors.errorPrimaryColor,
                      ),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return ConfirmDeleteDialog();
                          },
                        );

                        if (confirm != null && confirm) {
                          await getBox<Resident>().delete(r.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
              // DataGridCell(columnName: "id", value: r.id),
              DataGridCell(columnName: "name", value: r.fullname),
              DataGridCell(columnName: "gender", value: r.gender.name.title()),
              DataGridCell(
                columnName: "civilStatus",
                value: r.civilStatus.name.title(),
              ),
              DataGridCell(
                columnName: "birthdate",
                value: DateFormat("MMM d, y").format(r.birthDate),
              ),
              DataGridCell(columnName: "age", value: r.age),
              DataGridCell(columnName: "birthplace", value: r.birthPlace),
              DataGridCell(columnName: "contactNo", value: r.contactNumber),
              DataGridCell(columnName: "nationality", value: r.nationality),
              DataGridCell(columnName: "religion", value: r.religion),
              DataGridCell(columnName: "occupation", value: r.occupation),
              DataGridCell(
                columnName: "nationalIdNo",
                value: r.nationalIdNumber,
              ),
              DataGridCell(columnName: "purok", value: r.purok ?? ""),
              DataGridCell(columnName: "houseNo", value: r.houseNo),
              DataGridCell(columnName: "street", value: r.street),
            ],
          );
        }).toList();
  }

  final BuildContext context;
  List<DataGridRow> _residentsData = [];

  @override
  List<DataGridRow> get rows => _residentsData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((e) {
            return e.columnName == "actions"
                ? e.value
                : Container(
                  alignment:
                      e.columnName == "age"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  padding: EdgeInsets.all(8.0),
                  child: Text(e.value.toString(), softWrap: false),
                );
          }).toList(),
    );
  }
}
