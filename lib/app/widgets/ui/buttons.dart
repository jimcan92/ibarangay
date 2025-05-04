import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class ThemedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  late final ButtonStyle? style;

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

class TileButton extends StatelessWidget {
  const TileButton({
    super.key,
    this.onPressed,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.leadingColor,
    this.trailingColor,
    this.leadingSize,
    this.trailingSize,
  });

  final VoidCallback? onPressed;
  final String title;
  final String? subtitle;
  final IconData? leading;
  final IconData? trailing;
  final Color? leadingColor;
  final Color? trailingColor;
  final double? leadingSize;
  final double? trailingSize;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            Icon(leading, size: leadingSize ?? 24, color: leadingColor),
            SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: FluentTheme.maybeOf(context)!.typography.subtitle,

                  // overflow: TextOverflow.ellipsis,
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    textAlign: TextAlign.left,
                    style: FluentTheme.maybeOf(context)!.typography.caption,
                  ),
              ],
            ),
          ),
          // Spacer(),
          Icon(trailing, color: trailingColor, size: trailingSize),
        ],
      ),
    );
  }
}
