import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:system_theme/system_theme.dart';

part 'settings.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() => SettingsState(color: systemAccentColor);

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setWindowEffect(WindowEffect effect, BuildContext context) async {
    Window.setEffect(
      effect: effect,
      color:
          [WindowEffect.solid, WindowEffect.acrylic].contains(effect)
              ? FluentTheme.of(
                context,
              ).micaBackgroundColor.withValues(alpha: 0.05)
              : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
    state = state.copyWith(effect: effect);
  }
}

class SettingsState {
  final ThemeMode mode;
  final WindowEffect effect;
  final AccentColor color;

  SettingsState({
    this.mode = ThemeMode.system,
    this.effect = WindowEffect.disabled,
    required this.color,
  });

  SettingsState copyWith({
    ThemeMode? mode,
    WindowEffect? effect,
    AccentColor? color,
  }) {
    return SettingsState(
      mode: mode ?? this.mode,
      effect: effect ?? this.effect,
      color: color ?? this.color,
    );
  }
}

AccentColor get systemAccentColor {
  if (defaultTargetPlatform.supportsAccentColor) {
    return AccentColor('system', {
      "lightest": SystemTheme.accentColor.lightest,
      'lighter': SystemTheme.accentColor.lighter,
      'light': SystemTheme.accentColor.light,
      'normal': SystemTheme.accentColor.accent,
      'dark': SystemTheme.accentColor.dark,
      'darker': SystemTheme.accentColor.darker,
      'darkest': SystemTheme.accentColor.darkest,
    });
  }

  return Colors.blue;
}
