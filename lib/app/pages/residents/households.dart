import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibarangay/app/models/household/household.dart';
import 'package:ibarangay/app/models/resident/resident.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/action/confirm_delete.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/household.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Households extends StatelessWidget {
  const Households({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24, top: 24, right: 24),
          child: TileButton(
            leading: FluentIcons.add_home,
            title: "Add New Household",
            subtitle: "Click to open new household information dialog.",
            trailing: FluentIcons.add,
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return HouseholdDialog();
                },
              );
            },
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: getBox<Household>().listenable(),
            builder: (context, residentsBox, child) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    gridLineColor: FluentTheme.of(context).cardColor,
                    selectionColor: FluentTheme.of(
                      context,
                    ).accentColor.withValues(alpha: 0.2),
                  ),
                  child: SfDataGrid(
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,

                    // selectionMode: SelectionMode.multiple,
                    source: HouseholdsDataSource(
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
                        columnName: 'no',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Household No."),
                        ),
                        maximumWidth: 150,
                        columnWidthMode: ColumnWidthMode.fill,
                      ),
                      GridColumn(
                        columnName: 'members',
                        label: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text("Members"),
                        ),
                        columnWidthMode: ColumnWidthMode.fill,
                      ),
                      // GridColumn(
                      //   columnName: 'civilStatus',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Civil Status"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'birthdate',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Birthdate"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'age',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Age"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'birthplace',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Birthplace"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'contactNo',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Contact No."),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'nationality',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Nationality"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'religion',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Religion"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'occupation',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Occupation"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'nationalIdNo',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("National ID Number"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'purok',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Purok"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'houseNo',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("House No"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
                      // GridColumn(
                      //   columnName: 'street',
                      //   label: Container(
                      //     padding: EdgeInsets.all(8),
                      //     alignment: Alignment.center,
                      //     child: Text("Street"),
                      //   ),
                      //   columnWidthMode: ColumnWidthMode.auto,
                      // ),
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

class HouseholdsDataSource extends DataGridSource {
  HouseholdsDataSource({
    required this.context,
    required List<Household> residents,
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
                            return HouseholdDialog(household: r);
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
                          await getBox<Household>().delete(r.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
              // DataGridCell(columnName: "id", value: r.id),
              DataGridCell(columnName: "no", value: r.id),
              DataGridCell(
                columnName: "members",
                value: r.members
                    .map((m) => getBox<Resident>().get(m)?.fullname)
                    .join(";  "),
              ),
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
                      e.columnName == "no"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  padding: EdgeInsets.all(8.0),
                  child: Text(e.value.toString(), softWrap: false),
                );
          }).toList(),
    );
  }
}
