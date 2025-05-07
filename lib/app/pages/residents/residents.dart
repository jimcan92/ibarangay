import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/router.dart';
import 'package:ibarangay/app/widgets/ui/buttons.dart';
import 'package:ibarangay/utils/extensions.dart';

class Residents extends StatefulWidget {
  const Residents({super.key, required this.child, required this.context});

  final Widget child;
  final BuildContext? context;

  @override
  State<Residents> createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {
  @override
  Widget build(BuildContext context) {
    final l = GoRouterState.of(
      context,
    ).uri.toString().split("/").elementAtOrNull(2);

    return ScaffoldPage(
      header: PageHeader(
        title: BreadcrumbBar(
          onItemPressed: (v) {
            if (v.value == "root") context.go(AppRoutes.residents);
          },
          chevronIconSize: 16,
          items: [
            BreadcrumbItem(label: Text("Residents"), value: "root"),
            if (l != null)
              BreadcrumbItem(label: Text(l.title()), value: "second"),
          ],
        ),
      ),
      content: widget.child,
    );
  }
}

class ResidentsRoot extends StatelessWidget {
  ResidentsRoot({super.key});

  final List<PageTileInfo> tiles = [
    PageTileInfo(
      location: AppRoutes.individuals,
      title: "Individual Residents",
      subtitle: "List of individual residents in the barangay.",
    ),
    PageTileInfo(
      location: AppRoutes.households,
      title: "Households",
      subtitle: "List of households in the barangay.",
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

class PageTileInfo {
  final String location;
  final String title;
  final String? subtitle;

  PageTileInfo({required this.location, required this.title, this.subtitle});
}
