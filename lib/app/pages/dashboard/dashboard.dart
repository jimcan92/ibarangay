import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  final List<DashboardCardInfo> items = [
    DashboardCardInfo(
      title: "Ordinances",
      icon: FluentIcons.articles,
      color: Colors.blue,
      route: '/ordinances',
    ),
    DashboardCardInfo(
      title: "Certificates",
      icon: FluentIcons.certificate,
      color: Colors.green,
      route: '/certificates',
    ),
    DashboardCardInfo(
      title: "Financials",
      icon: FluentIcons.money,
      color: Colors.orange,
      route: '/financials',
    ),
    DashboardCardInfo(
      title: "Health Reports",
      icon: FluentIcons.health,
      color: Colors.red,
      route: '/health-reports',
    ),
    DashboardCardInfo(
      title: "Livelihood",
      icon: FluentIcons.teamwork,
      color: Colors.purple,
      route: '/livelihood',
    ),
    DashboardCardInfo(
      title: "Bulletins",
      icon: FluentIcons.taskboard,
      color: Colors.teal,
      route: '/bulletins',
    ),
    DashboardCardInfo(
      title: "Meetings",
      icon: FluentIcons.event,
      color: Colors.orange,
      route: '/users',
    ),
    DashboardCardInfo(
      title: "Maps",
      icon: FluentIcons.map_directions,
      color: Colors.purple,
      route: '/settings',
    ),
  ];

  DashboardPage({super.key});

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth ~/ 200,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return DashboardTile(
                  title: item.title,
                  icon: item.icon,
                  color: item.color,
                  onTap: () {
                    // print('Tapped on ${item["title"]}');
                    context.go(item.route ?? '');
                  },
                );
              },
            );
          },
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
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
