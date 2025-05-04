import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibarangay/app/providers/settings/settings.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text("Settings")),
      children: [
        Text('Theme mode', style: FluentTheme.of(context).typography.subtitle),
        SizedBox(height: 10),
        ...List.generate(ThemeMode.values.length, (index) {
          final mode = ThemeMode.values[index];
          final rawLabel = mode.toString().replaceAll('ThemeMode.', '');
          final label = rawLabel[0].toUpperCase() + rawLabel.substring(1);

          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 8.0),
            child: RadioButton(
              checked: settings.mode == mode,
              onChanged: (value) {
                if (value) {
                  ref.read(settingsProvider.notifier).setThemeMode(mode);
                }
              },
              content: Text(label),
            ),
          );
        }),
        SizedBox(height: 20),
        Text(
          'Accent Color',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        SizedBox(height: 10),
        Wrap(
          children: [
            Tooltip(
              message: accentColorNames[0],
              child: _buildColorBlock(ref, systemAccentColor),
            ),
            ...List.generate(Colors.accentColors.length, (index) {
              final color = Colors.accentColors[index];
              return Tooltip(
                message: accentColorNames[index + 1],
                child: _buildColorBlock(ref, color),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildColorBlock(WidgetRef ref, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          ref.read(settingsProvider.notifier).setAccentColor(color);
        },
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isPressed) {
              return color.light;
            } else if (states.isHovered) {
              return color.lighter;
            }
            return color;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: AlignmentDirectional.center,
          child:
              ref.watch(settingsProvider).color == color
                  ? Icon(
                    FluentIcons.check_mark,
                    color: color.basedOnLuminance(),
                    size: 22.0,
                  )
                  : null,
        ),
      ),
    );
  }
}
