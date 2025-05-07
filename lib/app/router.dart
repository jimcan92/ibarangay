import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/pages/admin/admin.dart';
import 'package:ibarangay/app/pages/admin_records/admin_records.dart';
import 'package:ibarangay/app/pages/admin_records/budget.dart';
import 'package:ibarangay/app/pages/admin_records/ordinance.dart';
import 'package:ibarangay/app/pages/certificates/certificates.dart';
import 'package:ibarangay/app/pages/dashboard/dashboard.dart';
import 'package:ibarangay/app/pages/financials/financials.dart';
import 'package:ibarangay/app/pages/legal/legal.dart';
import 'package:ibarangay/app/pages/misc/misc.dart';
import 'package:ibarangay/app/pages/officials/officials.dart';
import 'package:ibarangay/app/pages/public_services/public_services.dart';
import 'package:ibarangay/app/pages/residents/households.dart';
import 'package:ibarangay/app/pages/residents/individuals.dart';
import 'package:ibarangay/app/pages/residents/residents.dart';
import 'package:ibarangay/app/pages/root.dart';
import 'package:ibarangay/app/pages/settings/settings.dart';
import 'package:ibarangay/app/pages/users/users.dart';

class AppRoutes {
  static const String root = "/";
  static const String settings = "/settings";
  static const String puroks = "/addresses/puroks";
  static const String addresses = "/addresses";
  static const String sitios = "/sitios";
  static const String adminRecords = "/adminRecords";
  static const String certificates = "/certificates";
  static const String publicService = "/public-service";
  static const String financial = "/financial";
  static const String legal = "/legal";
  static const String misc = "/misc";
  static const String ordinance =
      "/adminRecords/barangay_ordinance_&_resolution";
  static const String budget =
      "/adminRecords/barangay_budget_&_annual_plan_(AIP)";
  static const String minutes =
      "/adminRecords/minutes_of_barangay_sessions_&_meetings";
  static const String bdp = "/adminRecords/barangay_development_plan_(BDP)";
  static const String council = "/adminRecords/barangay_council_records";
  static const String inventory =
      "/adminRecords/inventory_of_brgy_properties_&_equipment";
  static const String users = "/users";
  static const String admin = "/admin";
  static const String officials = "/officials";
  static const String residents = "/residents";
  static const String households = "/residents/households";
  static const String individuals = "/residents/individuals";
}

final rootNavkey = GlobalKey<NavigatorState>();
final rootShellNavKey = GlobalKey<NavigatorState>();
final adminRecordsShellNavKey = GlobalKey<NavigatorState>();
final residentsShellNavKey = GlobalKey<NavigatorState>();

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
          path: AppRoutes.officials,
          builder: (context, state) {
            return Officials();
          },
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) {
            return SettingsPage();
          },
        ),
        ShellRoute(
          navigatorKey: residentsShellNavKey,
          builder: (context, state, child) {
            return Residents(
              context: residentsShellNavKey.currentContext,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: AppRoutes.residents,
              builder: (context, state) {
                return ResidentsRoot();
              },
            ),
            GoRoute(
              path: AppRoutes.individuals,
              builder: (context, state) {
                return Individuals();
              },
            ),
            GoRoute(
              path: AppRoutes.households,
              builder: (context, state) {
                return Households();
              },
            ),
          ],
        ),
        ShellRoute(
          navigatorKey: adminRecordsShellNavKey,
          builder: (context, state, child) {
            return AdminRecords(
              context: adminRecordsShellNavKey.currentContext,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: AppRoutes.adminRecords,
              builder: (context, state) => AdminRecordsRoot(),
            ),
            GoRoute(
              path: AppRoutes.ordinance,
              builder: (context, state) => Ordinance(),
            ),
            GoRoute(
              path: AppRoutes.budget,
              builder: (context, state) => Budget(),
            ),
            GoRoute(
              path: AppRoutes.minutes,
              builder: (context, state) => Minutes(),
            ),
            GoRoute(path: AppRoutes.bdp, builder: (context, state) => BDP()),
            GoRoute(
              path: AppRoutes.council,
              builder: (context, state) => Council(),
            ),
            GoRoute(
              path: AppRoutes.inventory,
              builder: (context, state) => Inventory(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.certificates,
          builder: (context, state) {
            return Certificates();
          },
        ),
        GoRoute(
          path: AppRoutes.residents,
          builder: (context, state) {
            return Individuals();
          },
        ),
        GoRoute(
          path: AppRoutes.publicService,
          builder: (context, state) {
            return PublicServices();
          },
        ),
        GoRoute(
          path: AppRoutes.financial,
          builder: (context, state) {
            return Financials();
          },
        ),
        GoRoute(
          path: AppRoutes.legal,
          builder: (context, state) {
            return Legal();
          },
        ),
        GoRoute(
          path: AppRoutes.misc,
          builder: (context, state) {
            return Misc();
          },
        ),
        GoRoute(
          path: AppRoutes.users,
          builder: (context, state) {
            return Users();
          },
        ),
        GoRoute(
          path: AppRoutes.admin,
          builder: (context, state) {
            return AdminPage();
          },
        ),
      ],
    ),
  ],
);
