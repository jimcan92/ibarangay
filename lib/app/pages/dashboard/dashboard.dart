import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/models/barangay_details/barangay_details.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/barangay_details.dart';
import 'package:ibarangay/utils/page_info.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      // : Colors.grey[100],
      header: PageHeader(
        title: Text('Dashboard'),
        // centerTitle: true,
        // elevation: 0,
        // backgroundColor: Colors.indigo,
      ),
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SetBarangayDetailsInfobar(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    itemCount: pages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth ~/ 200,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = pages[index];
                      return DashboardTile(
                        title: item.title,
                        icon: item.icon,
                        color: item.color,
                        onTap: () {
                          // print('Tapped on ${item["title"]}');
                          context.go(item.route);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCardInfo {
  final String title;
  final IconData icon;
  final Color color;
  final String? route;

  DashboardCardInfo({
    this.route,
    required this.title,
    required this.icon,
    required this.color,
  });
}

class DashboardTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: onTap,
      builder: (context, states) {
        final hovering = states.isHovered;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: hovering ? color : color.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (hovering)
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 40, color: color.basedOnLuminance()),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: color.basedOnLuminance(),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SetBarangayDetailsInfobar extends StatefulWidget {
  const SetBarangayDetailsInfobar({super.key});

  @override
  State<SetBarangayDetailsInfobar> createState() =>
      _SetBarangayDetailsInfobarState();
}

class _SetBarangayDetailsInfobarState extends State<SetBarangayDetailsInfobar> {
  @override
  Widget build(BuildContext context) {
    final notSet = getBox<BarangayDetails>().get('details') == null;

    if (notSet) {
      return Column(
        children: [
          InfoBar(
            title: Text("Barangay Details Not Set."),
            content: Text("Please set your barangay details."),
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
          SizedBox(height: 16),
        ],
      );
    }

    return SizedBox.shrink();
  }
}
