import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class ThemedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  late final ButtonStyle? style;

  // const AppFilledButton({
  //   super.key,
  //   required this.onPressed,
  //   required this.child,
  //   this.style,
  // });

  ButtonStyle styleFromColor(Color val) {
    final textColor =
        val.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((state) {
        if (state.isHovered) {
          return val.withAlpha(200);
        }

        return val;
      }),
      foregroundColor: WidgetStatePropertyAll(textColor),
    );
  }

  /// A primary styled button
  ThemedButton.primary({
    super.key,
    required this.onPressed,
    required this.child,
  }) {
    style = styleFromColor(SystemTheme.accentColor.defaultAccentColor);
  }

  /// A primary styled button
  ThemedButton.error({
    super.key,
    required this.onPressed,
    required this.child,
  }) {
    style = styleFromColor(Colors.errorPrimaryColor);
  }

  /// A primary styled button
  ThemedButton.warning({
    super.key,
    required this.onPressed,
    required this.child,
  }) {
    style = styleFromColor(Colors.warningPrimaryColor);
  }

  /// A primary styled button
  ThemedButton({super.key, required this.onPressed, required this.child}) {
    style = null;
  }

  @override
  Widget build(BuildContext context) {
    return Button(onPressed: onPressed, style: style, child: child);
  }
}
