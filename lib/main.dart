import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as fa;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibarangay/app/config.dart';
import 'package:ibarangay/app/providers/settings/settings.dart';
import 'package:ibarangay/app/router.dart';
import 'package:ibarangay/app/services/hive.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await SystemTheme.accentColor.load();

  if (isDesktop) {
    await fa.Window.initialize();
    if (isWindows) await fa.Window.hideWindowControls();

    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );

      await windowManager.setBackgroundColor(SystemTheme.accentColor.accent);

      await windowManager.setMinimumSize(const Size(800, 600));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(settingsProvider);

    // ref
    //     .read(settingsProvider.notifier)
    //     .setWindowEffect(fa.WindowEffect.acrylic, context);

    return FluentApp.router(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      // darkTheme: FluentThemeData.dark(),
      themeMode: theme.mode,
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: theme.color,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        accentColor: theme.color,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
