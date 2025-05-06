import 'package:fluent_ui/fluent_ui.dart';
import 'package:ibarangay/app/router.dart';

class PageInfo {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const PageInfo({
    required this.route,
    required this.title,
    required this.icon,
    required this.color,
  });
}

final List<PageInfo> pages = [
  PageInfo(
    title: "Barangay Officials",
    icon: FluentIcons.org,
    color: Colors.accentColors[1],
    route: AppRoutes.adminRecords,
  ),
  PageInfo(
    title: "Residents",
    icon: FluentIcons.people_add,
    color: Colors.accentColors[2],
    route: AppRoutes.residents,
  ),
  PageInfo(
    title: "Administrative Records",
    icon: FluentIcons.admin_a_logo32,
    color: Colors.accentColors[3],
    route: AppRoutes.adminRecords,
  ),
  PageInfo(
    title: "Certificates & Clearances",
    icon: FluentIcons.certificate,
    color: Colors.accentColors[4],
    route: AppRoutes.certificates,
  ),
  PageInfo(
    title: "Public Services & Programs",
    icon: FluentIcons.c_r_m_resource_optimization_app32,
    color: Colors.accentColors[5],
    route: AppRoutes.publicService,
  ),
  PageInfo(
    title: "Financial Documents",
    icon: FluentIcons.financial,
    color: Colors.accentColors[6],
    route: AppRoutes.financial,
  ),
  PageInfo(
    title: "Legal & Complaint Records",
    icon: FluentIcons.compare,
    color: Colors.accentColors[7],
    route: AppRoutes.legal,
  ),
  PageInfo(
    title: "Miscellaneous",
    icon: FluentIcons.grid_view_small,
    color: Colors.accentColors[1],
    route: AppRoutes.misc,
  ),
];
