import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as fa;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibarangay/app/providers/settings/settings.dart';
import 'package:system_theme/system_theme.dart';

final _WindowsWindowEffects = [
  fa.WindowEffect.disabled,
  fa.WindowEffect.solid,
  fa.WindowEffect.transparent,
  fa.WindowEffect.aero,
  fa.WindowEffect.acrylic,
  fa.WindowEffect.mica,
  fa.WindowEffect.tabbed,
];

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text("Settings")),
      children: [
        ToggleSwitch(
          checked: settings.mode == ThemeMode.dark,
          onChanged: (value) {
            ref
                .read(settingsProvider.notifier)
                .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            ref
                .read(settingsProvider.notifier)
                .setWindowEffect(settings.effect, context);
          },
          content: Text("Dark Mode"),
        ),
        const SizedBox(height: 20),
        Button(
          onPressed: () async {
            await fa.Window.setEffect(effect: fa.WindowEffect.mica, dark: true);
          },
          child: Text("System Default"),
        ),
        if (defaultTargetPlatform.supportsAccentColor) ...[
          Text(
            'Window Transparency',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          Text(
            'Running on ${defaultTargetPlatform.toString().replaceAll('TargetPlatform.', '')}',
          ),
          ...List.generate(_WindowsWindowEffects.length, (index) {
            final mode = _WindowsWindowEffects[index];
            return Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 8.0),
              child: RadioButton(
                checked: settings.effect == mode,
                onChanged: (value) {
                  if (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setWindowEffect(mode, context);
                  }
                },
                content: Text(mode.toString().replaceAll('WindowEffect.', '')),
              ),
            );
          }),
        ],
      ],
    );
  }
}
