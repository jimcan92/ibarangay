import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ibarangay/app/config.dart';
import 'package:ibarangay/app/models/user/user.dart';
import 'package:ibarangay/app/providers/infobar/infobar.dart';
import 'package:ibarangay/app/providers/user/user.dart';
import 'package:ibarangay/app/router.dart';
import 'package:ibarangay/app/widgets/ui/dialogs/barangay_details.dart';
import 'package:ibarangay/utils/page_info.dart';
import 'package:window_manager/window_manager.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key, required this.child, required this.context});

  final Widget child;
  final BuildContext? context;

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> with WindowListener {
  int selected = 0;
  bool admin = false;
  User? user;

  late final List<NavigationPaneItem> paneItems =
      [
        PaneItem(
          key: const ValueKey(AppRoutes.root),
          icon: const Icon(FluentIcons.b_i_dashboard),
          title: const Text('Dashboard'),
          body: const SizedBox.shrink(),
        ),
        PaneItemSeparator(),
        ...pages.map(
          (e) => PaneItem(
            key: ValueKey(e.route),
            icon: Icon(e.icon),
            title: Text(e.title),
            body: const SizedBox.shrink(),
            onTap: () {
              if (GoRouterState.of(context).uri.toString() != e.route) {
                context.go(e.route);
              }
            },
          ),
        ),
      ].map<NavigationPaneItem>((e) {
        if (e is PaneItemExpander) {
          return PaneItemExpander(
            key: e.key,
            icon: e.icon,
            title: e.title,
            body: e.body,
            items:
                e.items.map((item) {
                  if (item is PaneItem) return buildPaneItem(item);
                  return item;
                }).toList(),
          );
        }
        if (e is PaneItem) return buildPaneItem(e);
        return e;
      }).toList();

  late final List<NavigationPaneItem> adminPaneItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey(AppRoutes.admin),
      icon: const Icon(FluentIcons.admin),
      title: const Text('Admin'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != AppRoutes.admin) {
          context.go(AppRoutes.admin);
        }
      },
    ),
  ];

  late final List<NavigationPaneItem> footers = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey(AppRoutes.settings),
      icon: const Icon(FluentIcons.info),
      title: const Text('Barangay Details'),
      body: const SizedBox.shrink(),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return BarangayDetailsDialog();
          },
        );
      },
    ),
    PaneItem(
      key: const ValueKey(AppRoutes.settings),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != AppRoutes.settings) {
          context.go(AppRoutes.settings);
        }
      },
    ),
  ];

  void onSelect(int? val) {
    if (val == null || selected == val) return;

    selected = val;

    reload();
  }

  void reload() => setState(() {});

  @override
  void initState() {
    windowManager.addListener(this);

    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userBoxProvider);

    bool hasUser = user != null;

    ref.listen<AppInfo?>(infobarProvider, (_, next) {
      if (next != null) {
        displayInfoBar(
          context,
          duration: const Duration(seconds: 5),
          alignment: Alignment.bottomRight,
          builder: (context, close) {
            return InfoBar(
              title: next.title,
              action: next.action,
              content: next.content,
              severity: next.severity,
            );
          },
        );
      }
    });

    int calculateSelectedIndex(BuildContext context) {
      final location =
          "/${GoRouterState.of(context).uri.toString().split("/")[1]}";

      int indexOriginal = (paneItems + adminPaneItems)
          .where((item) => item.key != null)
          .toList()
          .indexWhere((item) => item.key == Key(location));

      if (indexOriginal == -1) {
        int indexFooter = footers
            .where((element) => element.key != null)
            .toList()
            .indexWhere((element) => element.key == Key(location));
        if (indexFooter == -1) {
          return 0;
        }

        return (paneItems + adminPaneItems)
                .where((element) => element.key != null)
                .toList()
                .length +
            indexFooter;
      } else {
        return indexOriginal;
      }
    }

    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        leading: FlutterLogo(),
        height: 40,
        title: Text(appTitle),
        actions: WindowCaption(
          backgroundColor: Colors.transparent,
          brightness: FluentTheme.of(context).brightness,
        ),
      ),
      pane:
          hasUser
              ? NavigationPane(
                selected: calculateSelectedIndex(context),
                onChanged: onSelect,
                items:
                    user.role.isAdmin ? paneItems + adminPaneItems : paneItems,
                footerItems: footers,

                header: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: "Logged in user",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: user.role.color,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: user.role.color.withValues(
                                          alpha: 0.5,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  user.role.name,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: "Logout",
                        child: IconButton(
                          icon: const Icon(FluentIcons.sign_out),
                          onPressed: () {
                            ref.read(userBoxProvider.notifier).logout();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : null,
      paneBodyBuilder:
          hasUser
              ? (item, body) {
                final name =
                    item?.key is ValueKey
                        ? (item!.key as ValueKey).value
                        : null;

                return FocusTraversalGroup(
                  key: ValueKey('body$name'),
                  child: widget.child,
                );
              }
              : null,
      content: hasUser ? null : Login(),
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  PaneItem buildPaneItem(PaneItem item) {
    return PaneItem(
      key: item.key,
      icon: item.icon,
      title: item.title,
      body: item.body,
      onTap: () {
        final path = (item.key as ValueKey).value;
        if (GoRouterState.of(context).uri.toString() != path) {
          context.go(path);
        }
        item.onTap?.call();
      },
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;

  bool showPassword = false;

  void toggleShowPassword() {
    showPassword = !showPassword;

    reload();
  }

  void reload() => setState(() {});

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      usernameFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (ref.read(userBoxProvider) != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.root);
      });

      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void onLogin() {
      ref
          .read(userBoxProvider.notifier)
          .login(usernameController.text, passwordController.text)
          .then((success) {
            if (success) {
              ref
                  .read(infobarProvider.notifier)
                  .set(
                    AppInfo.success(
                      title: const Text("Success!"),
                      content: const Text("Successfully logged in."),
                    ),
                  );
            } else {
              ref
                  .read(infobarProvider.notifier)
                  .set(
                    AppInfo.error(
                      title: const Text("Error!"),
                      content: const Text("Invalid username or password."),
                    ),
                  );
            }
          });
    }

    return ScaffoldPage(
      content: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              InfoLabel(
                label: "Username",
                child: TextBox(
                  placeholder: 'Username',
                  controller: usernameController,
                  onChanged: (value) {
                    reload();
                  },
                  suffix:
                      usernameController.text.isEmpty
                          ? null
                          : IconButton(
                            focusable: false,
                            icon: const Icon(FluentIcons.clear),
                            onPressed: () {
                              usernameController.clear();
                              reload();
                            },
                          ),
                ),
              ),
              InfoLabel(
                label: "Password",
                child: TextBox(
                  placeholder: 'Password',
                  controller: passwordController,
                  onSubmitted: (_) => onLogin(),
                  obscureText: !showPassword,
                  onChanged: (value) {
                    reload();
                  },
                  suffix:
                      passwordController.text.isEmpty
                          ? null
                          : IconButton(
                            focusable: false,
                            icon: const Icon(FluentIcons.clear),
                            onPressed: () {
                              passwordController.clear();
                              reload();
                            },
                          ),
                ),
              ),
              Checkbox(
                focusNode: FocusNode(skipTraversal: true),
                checked: showPassword,
                onChanged: (v) => toggleShowPassword(),
                content: const Text("Show password"),
              ),
              FilledButton(onPressed: onLogin, child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
