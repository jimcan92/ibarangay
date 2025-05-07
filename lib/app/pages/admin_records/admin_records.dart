import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/router.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/utils/extensions.dart';

class AdminRecords extends StatefulWidget {
  const AdminRecords({super.key, required this.child, required this.context});

  final Widget child;
  final BuildContext? context;

  @override
  State<AdminRecords> createState() => _AdminRecordsState();
}

class _AdminRecordsState extends State<AdminRecords> {
  @override
  Widget build(BuildContext context) {
    final l = GoRouterState.of(
      context,
    ).uri.toString().split("/").elementAtOrNull(2);

    return ScaffoldPage(
      header: PageHeader(
        title: BreadcrumbBar(
          onItemPressed: (v) {
            if (v.value == "root") context.go(AppRoutes.adminRecords);
          },
          chevronIconSize: 16,
          items: [
            BreadcrumbItem(label: Text("Admin Records"), value: "root"),
            if (l != null)
              BreadcrumbItem(label: Text(l.title()), value: "second"),
          ],
        ),
      ),
      content: widget.child,
    );
  }
}

class Minutes extends StatelessWidget {
  const Minutes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Minutes'));
  }
}

class BDP extends StatelessWidget {
  const BDP({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('BDP'));
  }
}

class Council extends StatelessWidget {
  const Council({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Council'));
  }
}

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Inventory'));
  }
}

class AdminRecordsRoot extends StatelessWidget {
  AdminRecordsRoot({super.key});

  final List<AdminRecordsTileInfo> tiles = [
    AdminRecordsTileInfo(
      location: AppRoutes.ordinance,
      title: "Barangay Ordinance & Resolution",
      subtitle:
          "Legislative measures shaping community policies and governance.",
    ),
    AdminRecordsTileInfo(
      location: AppRoutes.budget,
      title: "Barangay Budget & Annual Investment Plan (AIP)",
      subtitle:
          "Financial blueprint ensuring strategic allocation of barangay funds.",
    ),
    AdminRecordsTileInfo(
      location: AppRoutes.minutes,
      title: "Minutes of Barangay Sessions & Meetings",
      subtitle:
          "Official records documenting discussions and decisions in barangay meetings.",
    ),
    AdminRecordsTileInfo(
      location: AppRoutes.bdp,
      title: "Barangay Development Plan (BDP)",
      subtitle:
          "A roadmap for sustainable growth and progress within the community.",
    ),
    AdminRecordsTileInfo(
      location: AppRoutes.council,
      title: "Barangay Council Records",
      subtitle:
          "Chronicles of council activities, decisions, and official proceedings.",
    ),
    AdminRecordsTileInfo(
      location: AppRoutes.inventory,
      title: "Inventory of Barangay Properties & Equipment",
      subtitle:
          "A detailed list of barangay assets for efficient management and transparency.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView.separated(
        itemCount: tiles.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final tile = tiles[index];

          return TileButton(
            title: tile.title,
            subtitle: tile.subtitle ?? tile.title,
            trailing: FluentIcons.chevron_right,
            onPressed: () {
              context.push(tile.location);
            },
          );
        },
      ),
    );
  }
}

class AdminRecordsTileInfo {
  final String location;
  final String title;
  final String? subtitle;

  AdminRecordsTileInfo({
    required this.location,
    required this.title,
    this.subtitle,
  });
}
