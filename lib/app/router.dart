import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/pages/address/addresses.dart';
import 'package:ibarangay/app/pages/address/puroks.dart';
import 'package:ibarangay/app/pages/address/sitios.dart';
import 'package:ibarangay/app/pages/dashboard/dashboard.dart';
import 'package:ibarangay/app/pages/root.dart';
import 'package:ibarangay/app/pages/settings/settings.dart';
import 'package:ibarangay/app/pages/users/users.dart';

class AppRoutes {
  static const String root = "/";
  static const String settings = "/settings";
  static const String puroks = "/addresses/puroks";
  static const String addresses = "/addresses";
  static const String sitios = "/sitios";
  static const String users = "/users";
}

final rootNavkey = GlobalKey<NavigatorState>();
final rootShellNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavkey,
  routes: [
    ShellRoute(
      navigatorKey: rootShellNavKey,
      builder: (context, state, child) {
        return RootPage(context: rootShellNavKey.currentContext, child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.root,
          builder: (context, state) {
            return DashboardPage();
          },
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) {
            return SettingsPage();
          },
        ),
        GoRoute(
          path: AppRoutes.puroks,
          builder: (context, state) {
            return PuroksPage();
          },
        ),
        GoRoute(
          path: AppRoutes.addresses,
          builder: (context, state) {
            return AddressessPage();
          },
        ),
        GoRoute(
          path: AppRoutes.sitios,
          builder: (context, state) {
            return SitiosPage();
          },
        ),
        GoRoute(
          path: AppRoutes.users,
          builder: (context, state) {
            return Users();
          },
        ),
      ],
    ),
  ],
);
