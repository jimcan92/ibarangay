import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// --------------------- DATA MODEL ---------------------
class BudgetItem {
  final String item;
  final String description;
  final double amount;
  final String fundSource;
  final String category;
  final int year;

  BudgetItem({
    required this.item,
    required this.description,
    required this.amount,
    required this.fundSource,
    required this.category,
    required this.year,
  });
}

// --------------------- DATA SOURCE ---------------------
class BudgetDataSource extends DataGridSource {
  final List<BudgetItem> items;

  BudgetDataSource(this.items) {
    _rows =
        items.map((item) {
          return DataGridRow(
            cells: [
              DataGridCell(columnName: 'Item', value: item.item),
              DataGridCell(columnName: 'Description', value: item.description),
              DataGridCell(columnName: 'Amount', value: item.amount),
              DataGridCell(columnName: 'Fund Source', value: item.fundSource),
              DataGridCell(columnName: 'Category', value: item.category),
              DataGridCell(columnName: 'Year', value: item.year),
            ],
          );
        }).toList();
  }

  late final List<DataGridRow> _rows;

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells:
          row.getCells().map((cell) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${cell.value}',
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
    );
  }
}

// --------------------- UI ---------------------
class Budget extends StatelessWidget {
  const Budget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BudgetItem> budgetData = [
      BudgetItem(
        item: 'Road Repair',
        description: 'Asphalt overlay in Purok 3',
        amount: 500000,
        fundSource: 'IRA',
        category: 'Infrastructure',
        year: 2025,
      ),
      BudgetItem(
        item: 'Health Program',
        description: 'Medical mission and supplies',
        amount: 200000,
        fundSource: 'Local Revenue',
        category: 'Health',
        year: 2025,
      ),
      BudgetItem(
        item: 'Educational Assistance',
        description: 'Scholarships for 50 students',
        amount: 300000,
        fundSource: '20% Dev Fund',
        category: 'Education',
        year: 2025,
      ),
      BudgetItem(
        item: 'Disaster Kit',
        description: 'Emergency kits and radios',
        amount: 120000,
        fundSource: 'Calamity Fund',
        category: 'Disaster Risk Reduction',
        year: 2025,
      ),
    ];

    final BudgetDataSource dataSource = BudgetDataSource(budgetData);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'List of budget allocations and planned programs for fiscal year 2025.',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SfDataGrid(
              source: dataSource,
              allowSorting: true,
              columnWidthMode: ColumnWidthMode.fill,
              columns: [
                GridColumn(
                  columnName: 'Item',
                  label: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Item'),
                  ),
                ),
                GridColumn(
                  columnName: 'Description',
                  label: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Description'),
                  ),
                ),
                GridColumn(
                  columnName: 'Amount',
                  label: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Amount'),
                  ),
                ),
                GridColumn(
                  columnName: 'Fund Source',
                  label: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Fund Source'),
                  ),
                ),
                GridColumn(
                  columnName: 'Category',
                  label: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Category'),
                  ),
                ),
                GridColumn(
                  columnName: 'Year',
                  label: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Year'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
